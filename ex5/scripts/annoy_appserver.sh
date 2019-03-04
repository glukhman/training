while true; do
	curl $1:$2/posts
	sleep 1
done
