Password Generator
==================

これはなに
----------

自分が実践しているパスワード管理のChromeExtension実装である.

[「パスワードの管理を避ける」という考え方](http://dsas.blog.klab.org/archives/52164341.html)という記事に触発され,
自分のパスワード管理方法を公開しようと思ったのが経緯である.


使い方
------

### インストール

#### ローカルで自分でビルド

自分でビルドを行うには, `npm`と`bower`が必要である.

```
git clone git@github.com:yucchiy/password-generator.git
cd password-generator
npm install && bower install
```
GoogleChromeより, [extensionの設定画面](chrome://extensions/)を開き,
`app`ディレクトリを「Load unpacked extension」で読み込むことでインストールできる.

#### ウェブストアからインストール

そのうち申請します.


### 初期設定

読み込み後, このジェネレータの設定画面で`マスタートークン`を設定する.
設定しなくてもランダムな文字列が設定されるが, セキュリティの都合, 必ず設定する.


アイデア
--------

基本的なアイデアは, [「パスワードの管理を避ける」という考え方](http://dsas.blog.klab.org/archives/52164341.html)と変わらないが,
よりウェブサービスで使いやすいように, 予め設定しておいた`マスタートークン`と, ウェブページの`ドメイン`と,
ユーザのウェブページでの`ユーザID`を元にパスワードを作成するような実装となっている.
この時`ドメイン`は, 現在開いているタブのドメインを自動的に補完するので, 
ユーザは, 自分のユーザIDを入力するだけで簡単にパスワードを生成することができる.

基本的なアイデアは, [http://imoz.jp/password.html](http://imoz.jp/password.html)であるが, ウェブサービス
利用に特化した実装となっている.


### 具体的な実装

実装はCoffeeScriptで行うと以下の通り.

```
base64_encode(pack('H*', md5(username + "@" + domain + ":" + master_token))).split('')
```

ちなみに, `base64_encode`などの関数は, [php.js](http://phpjs.org/)を利用している.

### パスワードの変更

セキュリティの都合, このジェネレータで作ったパスワードをまとめて変更したい場合は, `マスタートークン`を
変更するだけで良い.

