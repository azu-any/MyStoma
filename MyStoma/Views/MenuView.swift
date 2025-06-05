import SwiftUI

struct MenuView: View {
    @State private var toggleRotation = false
    @StateObject var router = NavigationRouter()
    @State private var showSettingsPopover = false
    @State private var selectedCategory: StomaCategory? = nil
    let categories = [nil] + StomaCategory.allCases
    @State private var showCategoryPicker: Bool = false
    @State var selectedItem: InfoItem?
    @State private var showInfoModal = false
    
    let items: [InfoItem] = InfoItem.sampleItems
    
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Practice with Simulators")
                        .font(.title2)
                        .bold()
                        .padding(.leading)
                    
                    MenuCaroussel(data: CardData.sampleData)
                    
                    
                    HStack{
                        Text("Learn the Tools")
                            .font(.title2)
                            .bold()
                            .padding(.leading)
                        
                        Spacer()
                        
                        Button {
                            showCategoryPicker.toggle()
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .imageScale(.large)
                        }
                        .padding(.trailing)
                        .popover(isPresented: $showCategoryPicker) {
                            VStack(alignment: .leading) {
                                Text("Choose category")
                                    .font(.headline)
                                
                                Picker("Category", selection: $selectedCategory) {
                                    Text("All").tag(StomaCategory?.none)
                                    ForEach(StomaCategory.allCases) { category in
                                        Text(category.rawValue.capitalized).tag(Optional(category))
                                    }
                                }
                                .pickerStyle(.inline)
                            }
                            .padding()
                            .frame(width: 250)
                        }
                    }
                    
                    ToolCaroussel(
                        items: items.filter { selectedCategory == nil || $0.categories.contains(selectedCategory!) },
                        selectedItem: .constant(nil)
                    )
                    
                    Text("Connect with Stories")
                        .font(.title2)
                        .bold()
                        .padding(.leading)
                    
                    MenuCaroussel(data: CardData.storyData)
                }
                //.padding(.leading)
                
                //.background(Color.white.ignoresSafeArea())
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    toggleRotation.toggle()
                }
            }
            .navigationDestination(for: Route.self) { route in
                router.destination(for: route)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showInfoModal.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showSettingsPopover.toggle()
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                    .popover(isPresented: $showSettingsPopover) {
                        AppSettingsView()
                    }
                }
            }
            .sheet(isPresented: $showInfoModal) {
                InfoModalView()
            }
            .navigationTitle("Explore & Learn")
        }
        .environmentObject(router)
        //.background(Color.white.ignoresSafeArea())
        
    }
}

struct InfoModalView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 20) {
                Text("Disclaimer & Citations")
                    .font(.title)
                    .bold()
                Text("This app is intended for educational and informational purposes only and is not a substitute for professional medical advice, diagnosis, or treatment. Always consult a qualified healthcare provider with any questions you may have regarding a medical condition. \n\nAll data, references, and methodologies used in the app are transparently documented. You can review the full list of citations and supporting materials down below.")
                Spacer()
                Link("View Disclamer & Citations",
                      destination: URL(string: "https://burly-paddleboat-08e.notion.site/Disclaimer-Citations-209edfd114ce80809264f42020663388")!)
            }
            .padding()
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.large)
                    .padding()
            }
        }
    }
}

#Preview {
    MenuView()
        .environmentObject(NavigationRouter())
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy))
}
