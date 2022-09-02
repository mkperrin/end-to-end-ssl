# end-to-end-ssl
Basics of end to end encryption with varnish

Traffic flow:

ELB -> Varnish -> ELB -> Backend App (nginx)

Traditionally we terminate SSL at the ELB in front of varnish. All traffic after that is HTTP.

But if we want to have all network traffic be SSL, we need to help varnish.

Hitch (https://hitch-tls.org/) : Runs on the varnish instance to handle SSL termination in front of varnish. It could also be used in front of the backend app.

Stunnel (https://www.stunnel.org/) : Runs on the varnish instance as a varnish backend, handles SSL communication with real backend.

Sample configs for each piece included, along with terraform for a basic example.

Simple benchmarks included.
