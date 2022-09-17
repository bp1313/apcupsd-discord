FROM alpine:latest

# install apcupsd and curl (For Discord)
RUN apk update && apk add bash
RUN apk add --no-cache apcupsd
RUN apk add --no-cache curl

# copy over config and override scripts
ADD apcupsd.conf /etc/apcupsd/apcupsd.conf
ADD eventscriptoverrides /etc/apcupsd/tmpscripts

# fix permissions
RUN chmod -R 744 /etc/apcupsd/tmpscripts/
RUN mv -v /etc/apcupsd/tmpscripts/* /etc/apcupsd
RUN rm -rf /etc/apcupsd/tmpscripts

# run apcupsd
CMD [ "/sbin/apcupsd", "-b" ]