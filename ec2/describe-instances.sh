AWS_REGION=us-east-1
FILTER_NAME="group"
FILTER_VALUES="automacao-cli"

aws ec2 describe-instances \
  --region $AWS_REGION \
  --filters "Name=tag:$FILTER_NAME,Values=$FILTER_VALUES" "Name=instance-state-name,Values=running,stopped" \
  --query "Reservations[*].Instances[*].[InstanceId,ImageId,State.Name,Tags[?Key=='$FILTER_NAME'].Value]" --output table