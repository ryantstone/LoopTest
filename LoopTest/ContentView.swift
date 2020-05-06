import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    struct State: Equatable, Hashable {
        var menuIsOpen = false
        var hellos: IdentifiedArrayOf<HellosView.State> = []
    }
    
    enum Actions {
        case
        didTapMenuButton(id: UUID, word: HellosView.Actions),
        add
    }
    
    let store: Store<State, Actions>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                HStack {
                    ForEachStore(
                        self.store.scope(
                            state: \.hellos,
                            action: Actions.didTapMenuButton(id:word:)
                        ),
                        content: HellosView.init(store:)
                    )
                }
                Button(action: { viewStore.send(.add) }) {
                    Text("Add")
                }
            }
            
        }
    }
}


let contentViewReducer = Reducer<ContentView.State, ContentView.Actions, Void>.combine(
    .init { state, actions, _ in
    switch actions {
    case .didTapMenuButton(id: let id, word: let helloState):
        state.hellos[id: id] = nil
    case .add:
        state.hellos.append(.init(message: "Hello"))
        }
        
        return .none
    }, helloViewReducer.forEach(
        state: \ContentView.State.hellos,
        action: /ContentView.Actions.didTapMenuButton(id:word:),
        environment: { $0 }
    )
)

let helloViewReducer = Reducer<HellosView.State, HellosView.Actions, Void> .init { state, actions, _ in
    switch actions {
    case .didTapText:
        break
    }
    
    return .none
}
