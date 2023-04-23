//
//  SegmentView.swift
//  SwiftyWords
//
//  Created by Philipp on 22.04.23.
//

import SwiftUI

struct SegmentView: View {
    let segment: Segment

    var body: some View {
        Text(segment.text)
            .opacity(segment.isUsed ? 0 : 1)
            .font(.title3)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(.indigo)
            .cornerRadius(5)
    }
}

struct SegmentView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentView(segment: .example)
    }
}
