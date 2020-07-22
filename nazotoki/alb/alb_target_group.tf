resource "aws_lb_target_group" "nazotoki" {
  name   = "nazotoki"
  vpc_id = data.terraform_remote_state.outputs.vpc.vpc_id
  port   = 80
  # target_type = "ip" # ECS Fargateの場合、IPアドレスによるルーティングが必要なので指定する
  protocol             = "HTTP" # 外部からALBはHTTPSでアクセス、ALB内部はHTTP
  deregistration_delay = 300    # ターゲットを登録解除する前のALBの待機時間(デフォルトは300)

  health_check {
    path                = "/"            # ヘルスチェックで使用するパス 
    healthy_threshold   = 5              # 正常判定するまでのヘルスチェック実行回数
    unhealthy_threshold = 2              # 異常判定するまでのヘルスチェック実行回数
    timeout             = 5              # ヘルスチェックのタイムアウト時間(秒)
    interval            = 30             # ヘルスチェックの実行間隔(秒)
    matcher             = 200            # 正常判定となるためのステータスコード(200に設定)
    port                = "traffic-port" # ヘルスチェックにしようするポート("traffic-port"と指定すると上で指定したポート)
    protocol            = "HTTP"         # ヘルスチェック時に使用するプロトコル
  }
}
