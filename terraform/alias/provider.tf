provider "aws"{
  region="us-east-1"
}

provider "aws"{
  alias="ohio"
  region="us-west-1"
}
