import Quick
import Nimble
import MaterialKit
import UIKit

class FakeLightsCardDelegate : LightsCardCallback {
    var tappedBulb : Bulb? = nil
    func didTapBulb(bulb: Bulb) {
        tappedBulb = bulb
    }

    var tappedSettings = false
    func didTapSettings() {
        tappedSettings = true
    }
}

class LightsCardSpec: QuickSpec {
    override func spec() {
        var subject: LightsCard! = nil
        var delegate : FakeLightsCardDelegate! = nil

        let bulb1 = Bulb(id: 3, name: "Hue Lamp 2", on: false, brightness: 194, hue: 15051,
            saturation: 137, colorTemperature: 359, transitionTime: 10, colorMode: .colorTemperature,
            effect: .none, reachable: true, alert: "none")

        let bulb2 = Bulb(id: 2, name: "Hue Lamp 1", on: false, brightness: 194, hue: 15051,
            saturation: 137, colorTemperature: 359, transitionTime: 10, colorMode: .hue,
            effect: .none, reachable: false, alert: "none")

        beforeEach {
            subject = LightsCard()

            delegate = FakeLightsCardDelegate()
            subject.configure(UITableView(), bulbs: [bulb1, bulb2], delegate: delegate)
        }

        describe("tableView") {
            it("have a cell for each bulb it's configured with") {
                expect(subject.numberOfCells()).to(equal(2))
            }

            describe("cells") {
                it("should be LightsTableViewCells") {
                    let cell1 = subject.cellAtIndex(0)
                    expect(cell1).to(beAnInstanceOf(LightsTableViewCell.self))

                    let cell2 = subject.cellAtIndex(1)
                    expect(cell2).to(beAnInstanceOf(LightsTableViewCell.self))
                }

                describe("Tapping on a cell") {
                    context("that is reachable") {
                        it("should notify the delegate") {
                            subject.didTapCell(0)
                            expect(delegate.tappedBulb).to(equal(bulb1))
                        }
                    }

                    context("that isn't reachable") {
                        it("shouldn't notify the delegate") {
                            subject.didTapCell(1)
                            expect(delegate.tappedBulb).to(beNil())
                        }
                    }
                }
            }

            describe("footer") {
                var footer: UIView? = nil

                beforeEach {
                    footer = subject.footerView().subviews.first as? UIView
                }

                it("should be an MKButton") {
                    expect(footer).to(beAnInstanceOf(MKButton.self))
                }

                it("with title 'Settings'") {
                    if let footer = footer as? MKButton {
                        expect(footer.titleForState(.Normal)).to(equal("Settings"))
                    }
                }

                it("when tapped it notifies the delegate") {
                    if let footer = footer as? MKButton {
                        footer.sendActionsForControlEvents(.TouchUpInside)

                        expect(delegate.tappedSettings).to(beTruthy())
                    }
                }
            }
        }
    }
}
