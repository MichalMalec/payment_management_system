# README

Setup test data:
`bin/rake db:setup`

Run app:
`bin/rails s`

Testing webhooks:
1. Make sure server is running locally
2. Install and run ngrok (for tunneling local url):
`ngrok http 3000`
3. Copy url returned by ngrok, e.g. `https://bbef-80-238-117-82.ngrok-free.app`
4. Login to Stripe -> Developer -> Webhooks -> Add endpoint
5. Type url from point 3, but with the webhooks ending -> `https://bbef-80-238-117-82.ngrok-free.app/webhooks/stripe`
6. Choose events -> `checkout.session.completed` and `invoice.payment_failed`
7. After creating a webhook in stripe you will see Signing Secret, copy it
8. Now in root dir enter: `EDITOR="code --wait" bin/rails credentials:edit` and paste Signing Secret from point 7 in `webhook_secret` section
9. [temp solution] now go to `config/environments/development.rb` and add `config.hosts << "bbef-80-238-117-82.ngrok-free.app"` - rails are blocking urls by default
10. Now in one terminal tab is running server, in the second is running ngrok. In the third tab test webhooks: `stripe trigger checkout.session.completed`, `sstripe trigger invoice.payment_failed` (make sure to have stripe cli installed)
