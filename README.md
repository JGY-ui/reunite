@startuml


/'
    실종자 클래스
'/

class MissingPerson {
    +occrde: String
    +alldressingDscd: String
    +ageNow: Int
    +age: Int
    +writngTrgetDscd: String
    +sexdstnDscd: String
    +occrAdres: String
    +nm: String
    +height: Int?
    +bdwgh: Int?
    +frmDscd: String?
    +faceshpeDscd: String?
    +hairshpeDscd: String?
    +haircolrDscd: String?
    +tknphotolength: String?
    +photoUrl: String
    +latitude: double?
    +longitude: double?
}

/'
    실종자 mmvm
'/

class MissingPersonDetailViewModel {
    -missingPerson: MissingPerson

    +getMissingPerson() -> MissingPerson
}

'실종자 인터페이스
interface MissingPersonDetailRepository {
    +getMissingPersonList(String MissingPerson, String MissingPerson, String MissingPerson) --> MissingPerson
}

class MissingPersonDetailRepositoryImpl {
    +getMissingPersonList(String MissingPerson, String MissingPerson, String MissingPerson) --> MissingPerson
}

class FakeMissingPersonDetailRepositoryImpl {
    +getMissingPersonList(String MissingPerson, String MissingPerson, String MissingPerson) --> MissingPerson
}
 
' 실종자 서비스
interface MissingPersonDetailService {
    +getMissingPersonList(String MissingPerson, String MissingPerson, String MissingPerson) --> List<MissingPerson>
}

class MissingPersonDetailServiceImpl {
    +getMissingPersonList(String MissingPerson, String MissingPerson, String MissingPerson) --> List<MissingPerson>
}

class FakeMissingPersonDetailServiceImpl {
    +getMissingPersonList(String MissingPerson, String MissingPerson, String MissingPerson) --> List<MissingPerson>
}

/'
    위치 mmvm
'/

class Coordinate {
    - long: double 
    - lat: double
}

'디펜더싱 빠짐 Coordinate


/'공지사항 클래스'/
class Notice{
    +id: String
    +title: String
    +content: String
}

class NoticeViewModel{
    +NoticeList: List <Notice>
    +getNotice() --> Notice
}


interface NoticeRepository{
    '타임 스탬프 / 아이디 /  페이지 네이션? 최근 15개 어떤시점 이후로 15개 호출 
    +loadNotice() --> List<Notice>
}

class NoticeRepositoryImpl{
    +loadNotice() --> List<Notice>
}

class FakeNoticeRepositoryImpl{
    +loadNotice() --> List<Notice>
}

'인터페이스'
interface NoticeService{
    +loadNotice() --> List<Notice>
}

'가짜 데이터'
class FakeNoticeServiceImpl{
    +loadNotice() --> List<Notice>
}

'데이터 전달'
class NoticeServiceImpl{
    +loadNotice() --> List<Notice>
}

/'홈 화면'/
class HomeViewModel extends ChangeNotifier {
    -missingPersonList: List<MissingPerson>
    -noticeList: List<Notice>
    -myCurrentLocation: Coordinate

    +homeViewModelInit()

    'getter
    'Location 정보를 가지고 있음
    '데이터 바인딩으로 표시
    '컴포이효과 피하기 위해 자잘하게 분리하는 경우가 있음
    '분리 이유 -> 각각 로드가 완료 된 이후 화면 띄우기 위해서
    +loadMissingPersons()
    +loadNotices()
    +getMyCurrentLocation()
}

' 내 위치 정보

/'Geocoding을 이용한 위치 변환'/
'위치 인터페이스를 이용하여 Geocoding 위치 구현
interface HomeMyCurrentLocationRepository {
    +getMyCurrentLocation() --> Coordinate
}

class HomeMyCurrentLocationRepositoryImpl {
    +getMyCoordinate() -> Coordinate
}

class FakeHomeMyCurrentLocationRepositoryImpl {
    +getMyCoordinate() -> Coordinate
}

interface HomeMyCurrentLocationService {
    +getMyCurrentLocation() --> Coordinate
}

class HomeMyCurrentLocationServiceImpl {
    +getMissingPersonList(String address) --> List<MissingPerson>
}

class FakeHomeMyCurrentLocationServiceImpl {
    +getMissingPersonList(String address) --> List<MissingPerson>
}

' 내 위치 정보 기반 실종자
interface HomeMissingPersonsRepository {
    +loadMissingPersons(String address) --> List<MissingPerson>
}

class HomeMissingPersonsRepositoryImpl {
    +loadMissingPersons(String address) --> List<MissingPerson>
}

class FakeHomeMissingPersonsRepositoryImpl {
    +loadMissingPersons(String address) --> List<MissingPerson>
}

interface HomeMissingPersonsService {
    +getMissingPersonList(String address) --> List<MissingPerson>
}

class HomeMissingPersonsServiceImpl {
    +getMissingPersonList(String address) --> List<MissingPerson>
}

class FakeHomeMissingPersonsServiceImpl {
    +getMissingPersonList(String address) --> List<MissingPerson>
}

' 공지 사항
interface HomeNoticesRepository {
    ' 상위 5개 항목
    +loadNotice() --> List<Notice>
}

class HomeNoticeRepositoryImpl{
    +loadNotice() --> List<Notice>
}

class FakeHomeNoticeRepositoryImpl{
    +loadNotice() --> List<Notice>
}

interface HomeNoticeService{
    +loadNotice() --> List<Notice>
}

class HomeNoticeServiceImpl{
    +loadNotice() --> List<Notice>
}

class FakeHomeNoticeServiceImpl{
    +loadNotice() --> List<Notice>
}

/' ==== 홈 화면 관계도 ==== '/
HomeViewModel --> HomeMyCurrentLocationRepository
HomeViewModel --> HomeMissingPersonsRepository
HomeViewModel --> HomeNoticesRepository

' ==== 상속 관계 (인터페이스 구현) ====

HomeMyCurrentLocationRepository --|> HomeMyCurrentLocationRepositoryImpl
HomeMyCurrentLocationRepository --|> FakeHomeMyCurrentLocationRepositoryImpl

HomeMissingPersonsRepository --|> HomeMissingPersonsRepositoryImpl
HomeMissingPersonsRepository --|> FakeHomeMissingPersonsRepositoryImpl

HomeNoticesRepository --|> HomeNoticeRepositoryImpl
HomeNoticesRepository --|> FakeHomeNoticeRepositoryImpl

HomeMyCurrentLocationService --|> HomeMyCurrentLocationServiceImpl
HomeMyCurrentLocationService --|> FakeHomeMyCurrentLocationServiceImpl

HomeMissingPersonsService --|> HomeMissingPersonsServiceImpl
HomeMissingPersonsService --|> FakeHomeMissingPersonsServiceImpl

HomeNoticeService --|> HomeNoticeServiceImpl
HomeNoticeService --|> FakeHomeNoticeServiceImpl

' ==== 의존 관계 (서비스가 레포지토리에 의존) ====

HomeMyCurrentLocationRepositoryImpl ..> HomeMyCurrentLocationService
HomeMissingPersonsRepositoryImpl ..> HomeMissingPersonsService
HomeNoticeRepositoryImpl ..> HomeNoticeService

/'실종자 리스트 화면'/
class MissingPersonListViewModel extends ChangeNotifier {
    -missingPersonList: List<MissingPerson>
    +loadMissingPersons()
}

interface MissingPersonListRepository {
    +loadMissingPersonsList(String address) --> List<MissingPerson>
}

class MissingPersonListRepositoryImpl{
    +loadMissingPersonsList(String address) --> List<MissingPerson>
}
class FakeMissingPersonListRepositoryImpl{
    +loadMissingPersonsList(String address) --> List<MissingPerson>
}

interface MissingPersonListService {
    +loadMissingPersonsList(String address) --> List<MissingPerson>
}

class MissingPersonListServiceImpl {
    +loadMissingPersonsList(String address) --> List<MissingPerson>
}
class FakeMissingPersonListServiceImpl {
    +loadMissingPersonsList(String address) --> List<MissingPerson>
}

/' ==== 실종자 리스트 화면 관계도 ==== '/
MissingPersonListViewModel --> MissingPersonListRepository

' ==== 상속 관계 (인터페이스 구현) ====
MissingPersonListRepository --|> MissingPersonListRepositoryImpl
MissingPersonListRepository --|> FakeMissingPersonListRepositoryImpl

MissingPersonListService --|> MissingPersonListServiceImpl
MissingPersonListService --|> FakeMissingPersonListServiceImpl

' ==== 의존 관계 (서비스가 레포지토리에 의존) ====
MissingPersonListRepositoryImpl ..> MissingPersonListService


/'실종자 맵 화면'/
class MapViewModel extends ChangeNotifier {
    -coordinate : Coordinate 
    ' 가져온데이터 수정 하여 별도로 저장 하면 안됨 
    ' 차라리 별도의 데이터로 저장하여 가지고 있을 것
    -missingPersonList: List<MissingPerson>
    -missingPersonLocations : Map<Coordinate>
    +loadMissingPersons(String address)
    +getMyCurrentLocation()
    +changeCamera()
    +getCoordinateFromAddress(String address)
    +getAddressFromCoordinate(Coordinate coordinate)
}

'실종자
interface MapMissingPersonsRepository {
    +loadMissingPersons(String address) -->  List<MissingPerson>
}

class MapMissingPersonsRepositoryImpl {
    +loadMissingPersons(String address) -->  List<MissingPerson>
}

class FakeMapMissingPersonsRepositoryImpl {
    +loadMissingPersons(String address) -->  List<MissingPerson>
}

interface MapMissingPersonsService {
    +loadMissingPersons(String address) -->  List<MissingPerson>
}

class MapMissingPersonsServiceImpl {
    +loadMissingPersons(String address) -->  List<MissingPerson>
}

class FakeMapMissingPersonsServiceImpl {
    +loadMissingPersons(String address) -->  List<MissingPerson>
}

' 위치
interface MapLocationRepository {
    +getMyCoordinate() -> Coordinate
    +getCoordinateFromAddress(String address) -> Coordinate
    +getAddressFromCoordinate(Coordinate coordinate) -> String
}

class MapLocationRepositoryImpl {
    +getMyCoordinate() -> Coordinate
    +getCoordinateFromAddress(String address) -> Coordinate
    +getAddressFromCoordinate(Coordinate coordinate) -> String
}

class FakeMapLocationRepositoryImpl {
    +getMyCoordinate() -> Coordinate
    +getCoordinateFromAddress(String address) -> Coordinate
    +getAddressFromCoordinate(Coordinate coordinate) -> String
}

interface MapLocaterService {
    + getCurrentLocation() -> Coordinate
}

class MapGeoLocaterServiceImpl {
    + getCurrentLocation() -> Coordinate
}

class FakeMapGeoLocaterServiceImpl  {
    + getCurrentLocation() -> Coordinate
}

interface MapCodingService {
    + getCoordinateFromAddress(String address) -> Coordinate
    + getAddressFromCoordinate(Coordinate coordinate) -> String
}

class MapGeoCodingServiceImpl {
    + getCoordinateFromAddress(String address) -> Coordinate
    + getAddressFromCoordinate(Coordinate coordinate) -> String
}

class FakeMapGeoCodingServiceImpl {
    + getCoordinateFromAddress(String address) -> Coordinate
    + getAddressFromCoordinate(Coordinate coordinate) -> String
}

/' ==== 실종자 맵 화면 관계도 ==== '/

MapViewModel --> MapMissingPersonsRepository
MapViewModel --> MapLocationRepository

' ==== 상속 관계 (인터페이스 구현) ====
MapMissingPersonsRepository --|> MapMissingPersonsRepositoryImpl
MapMissingPersonsRepository --|> FakeMapMissingPersonsRepositoryImpl

MapLocationRepository --|> MapLocationRepositoryImpl
MapLocationRepository --|> FakeMapLocationRepositoryImpl

MapMissingPersonsService --|> MapMissingPersonsServiceImpl
MapMissingPersonsService --|> FakeMapMissingPersonsServiceImpl

MapLocaterService --|> MapGeoLocaterServiceImpl
MapLocaterService --|> FakeMapGeoLocaterServiceImpl

MapCodingService --|> MapGeoCodingServiceImpl
MapCodingService --|> FakeMapGeoCodingServiceImpl   

' ==== 의존 관계 (서비스가 레포지토리에 의존) ====
MapMissingPersonsRepositoryImpl ..> MapMissingPersonsService
MapLocationRepositoryImpl ..> MapLocaterService
MapLocationRepositoryImpl ..> MapCodingService

/'관계도'/

MissingPersonDetailViewModel --> MissingPerson

MissingPersonDetailViewModel --> MissingPersonDetailRepository

NoticeViewModel --> NoticeRepository
NoticeRepositoryImpl --> NoticeService


' ==== 상속 관계 (인터페이스 구현) ====

FakeMissingPersonDetailRepositoryImpl ..|> MissingPersonDetailRepository
MissingPersonDetailRepositoryImpl ..|> MissingPersonDetailRepository

MissingPersonDetailServiceImpl ..|> MissingPersonDetailService
FakeMissingPersonDetailServiceImpl ..|> MissingPersonDetailService

NoticeViewModel --|> Notice
NoticeServiceImpl ..|> NoticeService
FakeNoticeServiceImpl ..|> NoticeService


' ==== 의존 관계 (서비스가 레포지토리에 의존) ====

MissingPersonDetailRepositoryImpl ..> MissingPersonDetailService

NoticeRepositoryImpl ..> NoticeRepository
FakeNoticeRepositoryImpl ..> NoticeRepository

package "View (UI)" {
  
  class HomeView {
    +build()
  }

  class MissingPersonDetailView {
    +build()
  }

  class MissingPersonListView {
    +build()
  }

  class NoticeView {
    +build()
  }

  class MapView {
    +build()
  }

  class MapMissingPersonProfileViewView {
    +build()
  }

  MissingPersonDetailView --> MissingPersonDetailViewModel
  NoticeView --> NoticeViewModel

  MissingPersonListView --> MissingPersonListViewModel
  MapView --> MapViewModel
  HomeView --> HomeViewModel : uses via Provider
}

@enduml
