FROM alpine:3.2 

RUN apk update 
RUN apk upgrade 
RUN apk add curl bash
CMD /timecurl/time-curl.sh $TARGET_URL
