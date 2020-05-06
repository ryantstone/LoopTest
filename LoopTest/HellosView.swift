import SwiftUI
import ComposableArchitecture

struct HellosView: View {
    
    struct State: Equatable, Hashable, Identifiable {
        let id = UUID() // FIXME: This work should be done in the environment for testability.
        var message: String
    }
    enum Actions {
        case
        didTapText
    }
    
    let store: Store<State, Actions>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            Button(action: { viewStore.send(.didTapText) }) {
                Text(viewStore.state.message)
            }
        }
    }
}
