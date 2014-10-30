NodeでRailsのSprocketsを捨てる
===========

npmは入っている前提。

## Sprocketsがやること

- [ ] assets以下のファイルをpublicにコピーする
- [ ] coffeeをjsにする
- [ ] jsを繋げて1つのファイルにする
- [ ] assets以下のファイルにハッシュ値をつける
- [ ] image_tagなどのメソッドで、ハッシュ値のついたファイルへのリンクにする
- [ ] ファイルが更新されるたび、上記のことを行う

## 戦略

ハッシュ値をつける

### やること

#### gulp

- [x] assets以下の画像・CSSファイルをpublicにコピーする
- [x] coffeeをjsにする
- [x] bower_componentsのdist内にあるjsと自分の作ったjsファイルを、依存関係を考慮しながら繋げて、app.jsにして、tmp/javascripts以下に置く
- [x] ファイルが更新されるたび、上記のことを行う
- [x] assets以下のファイルにハッシュ値をつける
- [x] image_tagなどのメソッドで、ハッシュ値のついたファイルへのリンクにする


#### browserify

- [x] 依存関係を考慮しながら、jsを繋げて1つのファイルにする

#### Rails

- [ ] javascript_include_tab、stylesheet_link_tagなどを消して、ごく普通のhtmlにする

### やらないこと

- [ ] css.erbのasset_pathを置き換える。html.erbはできるけどcssは無理だった
- [ ] uglify

## bower

bower install

### bowerでインストールするもの

jQuery

## webpack

諦めてbrowserify使うことにした

## 

## gulp

uglify

livereload

gulp-sass

gulp-rev

gulp-rev-rails-manifest


https://github.com/joker1007/rails_browserify_sample

```
npm install --save-dev gulp gulp-browserify gulp-watch gulp-plumber gulp-rename coffeeify coffee-script
```

