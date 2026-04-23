# OneStageROS_demo

OneStageROS_demoは、開発体験の向上に焦点を当てた、OneStageROSのためのデモ環境です。
OneStageROSは[こちら](https://github.com/yulat214/OneStageROS)にて提供しています。

本デモはDocker環境として提供され、サンプルのロボットモデル、周辺パッケージのセットアップ、およびビルドプロセスが完了している状態です。
ローカルPCの環境を汚すことなく、煩雑な依存関係の解決に時間を取られずに、すぐに本質的な機能の検証や開発のスタートダッシュを切ることができます。

## 特徴

* コンテナ化されたオールインワン環境: サンプルロボットから周辺ノードまで、デモに必要な要素がすべてDockerコンテナ内に統合されています。
* 手軽な起動プロセス: `docker compose` コマンドを実行するだけで、誰でも同じ環境を瞬時に再現できます。
* 直感的な開発体験: 初学者でも迷わず操作できるように認知負荷を下げ、スムーズに動作確認ができる構成になっています。

## 必須環境

このプロジェクトを実行するには、事前に以下のインストールおよび環境設定が必要です。

* OS: Ubuntu 22.04/24.04、または Windows 11 (WSL2 / WSLg有効化済み) を推奨します。
* Docker
* Docker Compose

> 注意: GUIアプリケーションの起動について
> 本デモでは、コンテナ起動時に画面分割用のターミナル（Terminator）が立ち上がります。
> * **Ubuntu / Windows 11 (WSLg)**: 基本的にはそのままGUIが起動します。
> * **Mac / 古いバージョンのWindows**: X11フォワーディングの設定（VcXsrvなどの導入とディスプレイ設定）が別途必要になります。

## セットアップ

以下のステップで、手元でデモ環境を立ち上げることができます。

1. リポジトリのクローン
   ```bash
   git clone https://github.com/yulat214/OneStageROS_demo.git
   cd OneStageROS_demo
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
    ├── OneStageROS # 提供ツール
    └── turtlebot3_ws # サンプルのロボット情報
```

## 使用方法

1. Terminatorの操作ウィンドウを増やす
    
    右クリックで、「Split Horizontally」「Split Vertically」を選択し、画面を2枚以上に分割します。
<img width="1920" height="1200" alt="test_term" src="https://github.com/user-attachments/assets/9d33178f-4071-48fd-9b3b-0de2d0bb906b" />

2. アプリケーションの起動

   分割してできた画面に、それぞれコマンドを入力して起動します（順不問）。

    【ターミナル1: ロボットの起動】
    用途に合わせて、以下のどちらかのコマンドを実行してください。

    * 通常の起動の場合:
      ```bash
      ros2 launch turtlebot3_lime_bringup fake.launch.py start_rviz:=false
      ```
    * MoveItも含めて起動する場合:
      ```bash
      ros2 launch turtlebot3_lime_bringup moveit_fake.launch.py
      ```

    【ターミナル2: ツールの起動】
    ```bash
    cd OneStageROS && npm run start
    ```

3. アプリケーションへのアクセス
   起動完了後、ホスト側でブラウザを開き、`http://localhost:3000`にアクセスしてください。

4. 起動直後の画面
   以下のような画面が表示されれば、成功です。アクセスすると、ブラウザ上で完結する軽量な統合開発環境（IDE）が開きます。
   重い物理演算を省いたシミュレータが組み込まれており、サンプルのロボット（TurtleBot3 Lime）を用いたプログラミングや動作確認をすぐに体験できます。
<img width="1920" height="1160" alt="2026-04-23-18:54:15-screenshot" src="https://github.com/user-attachments/assets/d7300ba4-78a3-4a4f-8a32-99b12d36fe11" />

## 終了方法

デモ環境を終了し、コンテナを停止する場合は以下のコマンドを実行します。

```bash
docker compose stop
```

また、`docker compose up`を実行したターミナルでのCtrl+Cや、terminatorを閉じることでも終了できます。

## 2回目以降の起動方法

2回目以降は、以下のコマンドで起動可能です。
```bash
docker start tools_demoenv
```

## 試せる機能

画面が立ち上がったら、以下の操作を試すことができます。

* ロボットの移動
  * /cmd_velから速度司令を送ることが出来ます。
* アーム操作
  * /joint_statesから司令を送ることが出来ます。
* コード編集
* オブジェクトの配置・削除・保存・読込
  * 「配置するオブジェクトを選択」を押下し、`~/turtlebot3_ws/src/turtlebot3_lime/turtlebot3_lime_bringup/worlds/turtlebot3_world/meshes`内のメッシュを選択すると、配置することが出来ます。
