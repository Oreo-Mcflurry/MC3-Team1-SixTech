//
//  InfoView.swift
//  SixTech
//
//  Created by Junyoo on 2023/07/24.
//

import SwiftUI

struct InfoView: View {
	var body: some View {
		ZStack {
			Color.gray.ignoresSafeArea()
			VStack {
				HStack {
					Spacer()
					Image(systemName: "scope")
						.font(.system(size: 25))
						.foregroundColor(.gray)
						.padding(10)
						.background {
							Circle()
								.foregroundColor(.white)
								.shadow(radius: 0, x: 1, y: 1)
					}
				}
				.padding()

				Spacer()
				
//				ActivityDataView()
			}
		}
	}
}

struct ActivityDataView: View {
	@State private var pauseTapped = false
    @State private var isAlert = false
    
    var alert: ((Bool) -> Void)?

	var body: some View {
		ZStack {
			VStack {
				RectangleView {
					VStack {
						Spacer()
						TrackingInfoView(kilometer: "10.1", steps: "1,100", pickups: "1,111")
						Spacer()
						if pauseTapped {
							ElapsedTimeView(time: "12:34:56")
						}
					}
				}
				.frame(height: pauseTapped ? 150 : 70)
				if pauseTapped {
					RectangleView {
						MissionView(mission: "길가에 핀 꽃 사진찍기")
					}
				}
				
				if pauseTapped {
					HStack {
						ControlButtonView(buttonType: .stop) {
                            isAlert.toggle()
                            alert!(isAlert)
						}
						.padding(.bottom)
						.padding(.horizontal)
						
						ControlButtonView(buttonType: .play) {
							self.pauseTapped = false
						}
						.padding(.bottom)
						.padding(.horizontal)
					}
				} else {
					ControlButtonView(buttonType: .pause) {
						self.pauseTapped = true
					}
					.padding(.bottom)
				}
			}
		}
		.background {
			RoundedRectangle(cornerRadius: 40)
				.foregroundColor(.white)
				.shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
		}
	}
}

struct TrackingInfoView: View {
	var kilometer: String
	var steps: String
	var pickups: String

	var body: some View {
		HStack {
			Spacer()
			VStack {
				Text(kilometer)
					.font(.Jamsil.extraBold.font(size: 25))
					.foregroundColor(.fontColor)
				Text("km")
					.font(.Jamsil.light.font(size: 12))
			}
			Spacer()
			VStack {
				Text(steps)
					.font(.Jamsil.medium.font(size: 25))
					.foregroundColor(.fontColor)
				Text("걸음")
					.font(.Jamsil.light.font(size: 12))
			}
			Spacer()
			VStack {
				Text(pickups)
					.font(.Jamsil.medium.font(size: 25))
					.foregroundColor(.fontColor)
				Text("줍깅")
					.font(.Jamsil.light.font(size: 12))
			}
			Spacer()
		}
	}
}

struct ElapsedTimeView: View {
	var time: String

	var body: some View {
		VStack {
			Text(time)
				.font(.Jamsil.bold.font(size: 40))
				.kerning(4)
				.foregroundColor(.accentFontColor)
			.bold()
			Text("경과 시간")
				.font(.Jamsil.light.font(size: 12))
				.padding(.bottom)
		}
	}
}

struct MissionView: View {
	var mission: String

	var body: some View {
		VStack {
			Text("나의 같이줍깅 미션")
				.font(.Jamsil.light.font(size: 12))
				.padding(.top)
			Spacer()
			RoundedRectangle(cornerRadius: 10)
				.frame(maxWidth: 270, maxHeight: 40)
				.foregroundColor(.white)
				.padding(.horizontal)
				.padding(.horizontal)
				.overlay {
					Text(mission)
						.font(.Jamsil.regular.font(size: 16))
				}
			Spacer()
			RoundedRectangle(cornerRadius: 35)
				.frame(maxWidth: 270, maxHeight: 50)
				.shadow(color: .defaultColor, radius: 2.5, x: 0, y: 3)
				.foregroundColor(.defaultColor)
				.padding(.horizontal)
				.padding(.horizontal)
				.overlay {
					HStack {
						Image(systemName: "camera.fill")
						Text("미션 하러 가기")
							.font(.Jamsil.bold.font(size: 14))
					}
					.foregroundColor(.white)
				}
			Spacer()
		}
	}
}

private struct ControlButtonView: View {
	var buttonType: ControlButtonType
	var buttonAction: () -> Void

	var body: some View {
		Button(action: buttonAction) {
			Image(systemName: buttonType.systemName)
				.font(.system(size: 30))
				.bold()
				.shadow(radius: 0, x: 1, y: 1)
				.foregroundColor(.red)
				.padding()
				.background {
					Circle()
						.foregroundColor(.white)
						.shadow(color: .black.opacity(0.15), radius: 2.5, x: 1, y: 1)
				}
		}
	}
}

private enum ControlButtonType {
	case stop, play, pause

	var systemName: String {
		switch self {
		case .stop:
			return "stop.fill"
		case .play:
			return "play.fill"
		case .pause:
			return "pause.fill"
		}
	}
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}