import XCTest
@testable import EasyConstraints

final class EasyConstraintsTests: XCTestCase {
    var view: UIView!
        var superview: UIView!

        override func setUp() {
            super.setUp()
            superview = UIView()
            view = UIView()
            superview.addSubview(view)
        }

        override func tearDown() {
            view = nil
            superview = nil
            super.tearDown()
        }

        func testGetConstraint() {
            // Add a width constraint
            let widthConstraint = view.widthAnchor.constraint(equalToConstant: 100)
            widthConstraint.isActive = true

            // Verify getConstraint works correctly
            let fetchedConstraint = view.getConstraint(for: .width)
            XCTAssertEqual(fetchedConstraint, widthConstraint)
        }

        func testResetConstraints() {
            // Add and activate constraints
            let widthConstraint = view.widthAnchor.constraint(equalToConstant: 100)
            let heightConstraint = view.heightAnchor.constraint(equalToConstant: 200)
            widthConstraint.isActive = true
            heightConstraint.isActive = true

            // Simulate default values
            constraintInfo.widthDefault = 50
            constraintInfo.heightDefault = 150

            // Reset constraints to default values
            view.resetConstraints(to: [.width, .height])

            XCTAssertEqual(widthConstraint.constant, 50)
            XCTAssertEqual(heightConstraint.constant, 150)
        }

        func testGetAllConstraints() {
            // Add multiple constraints
            let topConstraint = view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10)
            let leadingConstraint = view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20)
            NSLayoutConstraint.activate([topConstraint, leadingConstraint])

            // Fetch all constraints for a specific attribute
            let fetchedTopConstraints = view.getAllConstraints(for: .top)
            let fetchedLeadingConstraints = view.getAllConstraints(for: .leading)

            XCTAssertTrue(fetchedTopConstraints.contains(topConstraint))
            XCTAssertTrue(fetchedLeadingConstraints.contains(leadingConstraint))
        }
}
