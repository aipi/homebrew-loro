# Homebrew Cask for Loro (ADR-0006). This is the single source of truth: the
# release workflow fills in the version and sha256 and publishes the result to
# the tap repo (aipi/homebrew-loro) as Casks/loro.rb. Do not edit the tap copy
# by hand — it is overwritten on every release.
cask "loro" do
  version "0.13.0"
  sha256 "8267da4f8b73b32420891a533911840015db42a9db6059b381880f821470538b"

  url "https://github.com/aipi/loro/releases/download/v#{version}/Loro_#{version}_aarch64.dmg"
  name "Loro"
  desc "Local live speech-to-text and per-domain knowledge base"
  homepage "https://github.com/aipi/loro"

  # The whisper engine and ffmpeg are system dependencies (ADR-0003); Homebrew
  # installs them automatically with the app. The ggml models are NOT bundled —
  # the app downloads the one you pick on first use, verified by SHA-256
  # (ADR-0006), so the install stays light.
  depends_on formula: ["whisper-cpp", "ffmpeg"]
  depends_on macos: :ventura
  depends_on arch: :arm64

  app "Loro.app"

  # Loro keeps no credentials and writes only under ~/.loro (BR-9); a full
  # uninstall removes that plus the app's macOS preference/state files.
  zap trash: [
    "~/.loro",
    "~/Library/Preferences/com.oaipi.loro.plist",
    "~/Library/Saved Application State/com.oaipi.loro.savedState",
  ]
end
