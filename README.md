# demo（仮）

demo（仮）は、開発体験の向上に焦点を当てた、tool（仮）のためのデモ環境です。

本デモはDocker環境として提供され、サンプルのロボットモデル、周辺パッケージのセットアップ、およびビルドプロセスが完了している状態です。
ローカルPCの環境を汚すことなく、煩雑な依存関係の解決に時間を取られずに、すぐに本質的な機能の検証や開発のスタートダッシュを切ることができます。

## 特徴

* コンテナ化されたオールインワン環境: サンプルロボットから周辺ノードまで、デモに必要な要素がすべてDockerコンテナ内に統合されています。
* 手軽な起動プロセス: `docker compose` コマンドを実行するだけで、誰でも同じ環境を瞬時に再現できます。
* 直感的な開発体験: 初学者でも迷わず操作できるように認知負荷を下げ、スムーズに動作確認ができる構成になっています。

## 必須環境

このプロジェクトを実行するには、事前に以下のインストールが必要です。

* Docker
* Docker Compose

## セットアップ

以下のステップで、手元でデモ環境を立ち上げることができます。

1. リポジトリのクローン
   ```bash
   https://github.com/yulat214/demo_environment.git
   cd demo_environment
   ```

2. イメージのビルドと起動

    必要なパッケージや設定を含んだDockerイメージをビルドします。（時間がかかります）
    ビルドが完了したら、コンテナを起動します。Terminatorの画面が起動します。
   ```bash
   docker compose build
   docker compose up
   # バックグラウンドで実行する場合は: docker compose up -d
   ```

## コンテナ内のファイル構成
```bash
/root
    ├── test_robot_tools # 提供ツール
    └── turtlebot3_ws # サンプルのロボット情報
```

## 使用方法

1. Terminatorの操作ウィンドウを増やす
    
    右クリックで、「Split Holizontally」「Split Vertically」を選択し、画面を4枚以上に分割します。

2. アプリケーションの起動
    - ロボットのlaunch
    - rosbridge
    - ツール

    を起動する必要があります。

分割してできた画面に、それぞれ、
```bash
cd test_robot_tools && run npm start
```

```bash
ros2 launch rosbridge_server rosbridge_websocket_launch.xml
```

```bash
ros2 launch turtlebot3_lime_bringup fake.launch.py 
```

を入力し、起動してください（順不問）

3. アプリケーションへのアクセス
   起動完了後、ホスト側でブラウザを開き、`http://localhost:3000`にアクセスしてください。

## 終了方法

デモ環境を終了し、コンテナを停止・削除する場合は以下のコマンドを実行します。

```bash
docker compose down
```

## 2回目以降の起動方法

2回目以降は、以下のコマンドで起動可能です。
```bash
docker start tools_demoenv
```

## 試せる機能

画面が立ち上がったら、以下の操作を試すことができます。

* [デモ操作1: 例 - ロボットの移動]: [操作方法の簡単な説明]
* [デモ操作2: 例 - 把持の実行]: [操作方法の簡単な説明]