require "language/go"

class Lxc < Formula
  desc "Pack, ship and run any linux OS as a lightweight container"
  homepage "https://linuxcontainers.org/lxd"
  url "https://github.com/lxc/lxd.git", :tag => "lxd-0.18"
  head "https://github.com/lxc/lxd.git"

  depends_on "go" => :build

  go_resource "github.com/lxc/lxd" do
    url "https://github.com/lxc/lxd.git", :tag => "lxd-0.18"
  end

  go_resource "github.com/chai2010/gettext-go" do
    url "https://github.com/chai2010/gettext-go.git"  #, :revision => "dfde2702d61cc95071f9def0fe9fc47d43136d6d"
  end

  go_resource "github.com/gorilla/websocket" do
    url "https://github.com/gorilla/websocket.git"
  end

  go_resource "github.com/olekukonko/tablewriter" do
    url "https://github.com/olekukonko/tablewriter.git"
  end

  go_resource "github.com/mattn/go-colorable" do
    url "https://github.com/mattn/go-colorable.git"
  end

  go_resource "golang.org/x/crypto" do
    url "https://go.googlesource.com/crypto.git"
  end

  go_resource "gopkg.in/yaml.v2" do
    url "https://github.com/go-yaml/yaml.git",
        :branch => "v2",
        :revision => "bec87e4332aede01fb63a4ab299d8af28480cd96"
  end

  go_resource "gopkg.in/inconshreveable/log15.v2" do
    url "https://github.com/inconshreveable/log15.git",
        :tag => "v2.11"
  end

  def install
    ENV["GOPATH"] = buildpath
    Language::Go.stage_deps resources, buildpath/"src"
    system "go", "build", "-o", "lxc-cli", "./lxc"
    bin.install "lxc-cli" => "lxc"
  end

  test do
    system "#{bin}/lxc", "--version"
  end
end
