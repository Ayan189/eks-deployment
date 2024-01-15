from datetime import datetime
import OpenSSL
import ssl
import requests

def check_ssl_expiry(domain, port):
    cert = ssl.get_server_certificate((domain, port))
    x509 = OpenSSL.crypto.load_certificate(OpenSSL.crypto.FILETYPE_PEM, cert)
    not_after_bytes = x509.get_notAfter()
    timestamp = not_after_bytes.decode('utf-8')
    expiration_date = datetime.strptime(timestamp, '%Y%m%d%H%M%S%z').date()
    days_until_expiry = (expiration_date - datetime.now().date()).days
    return days_until_expiry

def send_slack_notification(webhook_url, domain, days_until_expiry):
    message = f"SSL certificate for {domain} expires in {days_until_expiry} days. Renew it!"
    payload = {
        "text": message
    }
    response = requests.post(webhook_url, json=payload)
    response.raise_for_status()
    print(f"Slack notification sent successfully for {domain}.")


def main():
    domains_and_ports = [('www.google.com', 443), ('www.example.com', 443)] 
    slack_webhook_url = 'https://hooks.slack.com/services/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'  # Replace with your Slack webhook URL

    for domain, port in domains_and_ports:
        days_until_expiry = check_ssl_expiry(domain, port)

        if days_until_expiry <= 50: # for testing I have added the limit of 50 :)
            print(f"SSL certificate for {domain} expires in {days_until_expiry} days. Sending Slack notification.")
            send_slack_notification(slack_webhook_url, domain, days_until_expiry)
        else:
            print(f"SSL certificate for {domain} expires in {days_until_expiry} days.")

if __name__ == "__main__":
    main()
