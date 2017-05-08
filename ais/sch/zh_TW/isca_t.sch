/* 
================================================================================
檔案代號:isca_t
檔案名稱:其他申報資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table isca_t
(
iscaent       number(5)      ,/* 企業編碼 */
iscasite       varchar2(10)      ,/* 申報單位代碼 */
isca001       number(5,0)      ,/* 申報年度 */
isca002       number(5,0)      ,/* 申報月份 */
isca101       number(20,6)      ,/* 統一發票(進貨及費用)-專供課稅得扣抵(代號29) */
isca102       number(20,6)      ,/* 統一發票(進貨及費用)-專供課稅得扣抵 */
isca103       number(20,6)      ,/* 統一發票(進貨及費用)-共同使用-小計 */
isca104       number(20,6)      ,/* 統一發票(進貨及費用)-共同使用-比例得扣抵 */
isca105       number(20,6)      ,/* 統一發票(進貨及費用)-共同使用-比例不得扣抵 */
isca106       number(20,6)      ,/* 統一發票(進貨及費用)-專供免稅不得扣抵 */
isca107       number(20,6)      ,/* 統一發票(固定資產)-進項稅額合計(代號31) */
isca108       number(20,6)      ,/* 統一發票(固定資產)-專供課稅得扣抵 */
isca109       number(20,6)      ,/* 統一發票(固定資產)-共同使用-小計 */
isca110       number(20,6)      ,/* 統一發票(固定資產)-共同使用-比例得扣抵 */
isca111       number(20,6)      ,/* 統一發票(固定資產)-共同使用-比例不得扣抵 */
isca112       number(20,6)      ,/* 統一發票(固定資產)-專供免稅不得扣抵 */
isca201       number(20,6)      ,/* 三聯式(進貨及費用)-進項稅額合計(代號33) */
isca202       number(20,6)      ,/* 三聯式(進貨及費用)-專供課稅得扣抵 */
isca203       number(20,6)      ,/* 三聯式(進貨及費用)-共同使用-小計 */
isca204       number(20,6)      ,/* 三聯式(進貨及費用)-共同使用-比例得扣抵 */
isca205       number(20,6)      ,/* 三聯式(進貨及費用)-共同使用-比例不得扣抵 */
isca206       number(20,6)      ,/* 三聯式(進貨及費用)-專供免稅不得扣抵 */
isca207       number(20,6)      ,/* 三聯式(固定資產)-進項稅額合計(代號35) */
isca208       number(20,6)      ,/* 三聯式(固定資產)-專供課稅得扣抵 */
isca209       number(20,6)      ,/* 三聯式(固定資產)-共同使用-小計 */
isca210       number(20,6)      ,/* 三聯式(固定資產)-共同使用-比例得扣抵 */
isca211       number(20,6)      ,/* 三聯式(固定資產)-共同使用-比例不得扣抵 */
isca212       number(20,6)      ,/* 三聯式(固定資產)-專供免稅不得扣抵 */
isca301       number(20,6)      ,/* 載有稅額(進貨及費用)-進項稅額合計(代號37) */
isca302       number(20,6)      ,/* 載有稅額(進貨及費用)-專供課稅得扣抵 */
isca303       number(20,6)      ,/* 載有稅額(進貨及費用)-共同使用-小計 */
isca304       number(20,6)      ,/* 載有稅額(進貨及費用)-共同使用-比例得扣抵 */
isca305       number(20,6)      ,/* 載有稅額(進貨及費用)-共同使用-比例不得扣抵 */
isca306       number(20,6)      ,/* 載有稅額(進貨及費用)-專供免稅不得扣抵 */
isca307       number(20,6)      ,/* 載有稅額(固定資產)-進項稅額合計(代號39) */
isca308       number(20,6)      ,/* 載有稅額(固定資產)-專供課稅得扣抵 */
isca309       number(20,6)      ,/* 載有稅額(固定資產)-共同使用-小計 */
isca310       number(20,6)      ,/* 載有稅額(固定資產)-共同使用-比例得扣抵 */
isca311       number(20,6)      ,/* 載有稅額(固定資產)-共同使用-比例不得扣抵 */
isca312       number(20,6)      ,/* 載有稅額(固定資產)-專供免稅不得扣抵 */
isca401       number(20,6)      ,/* 海關代徵(進貨及費用)-進項稅額合計(代號79) */
isca402       number(20,6)      ,/* 海關代徵(進貨及費用)-專供課稅得扣抵 */
isca403       number(20,6)      ,/* 海關代徵(進貨及費用)-共同使用-小計 */
isca404       number(20,6)      ,/* 海關代徵(進貨及費用)-共同使用-比例得扣抵 */
isca405       number(20,6)      ,/* 海關代徵(進貨及費用)-共同使用-比例不得扣抵 */
isca406       number(20,6)      ,/* 海關代徵(進貨及費用)-專供免稅不得扣抵 */
isca407       number(20,6)      ,/* 海關代徵(固定資產)-進項稅額合計(代號81) */
isca408       number(20,6)      ,/* 海關代徵(固定資產)-專供課稅得扣抵 */
isca409       number(20,6)      ,/* 海關代徵(固定資產)-共同使用-小計 */
isca410       number(20,6)      ,/* 海關代徵(固定資產)-共同使用-比例得扣抵 */
isca411       number(20,6)      ,/* 海關代徵(固定資產)-共同使用-比例不得扣抵 */
isca412       number(20,6)      ,/* 海關代徵(固定資產)-專供免稅不得扣抵 */
isca501       number(20,6)      ,/* 退出及折讓(進貨及費用)-進項稅額合計(代號41) */
isca502       number(20,6)      ,/* 退出及折讓(進貨及費用)-專供課稅得扣抵 */
isca503       number(20,6)      ,/* 退出及折讓(進貨及費用)-共同使用-小計 */
isca504       number(20,6)      ,/* 退出及折讓(進貨及費用)-共同使用-比例得扣抵 */
isca505       number(20,6)      ,/* 退出及折讓(進貨及費用)-共同使用-比例不得扣抵 */
isca506       number(20,6)      ,/* 退出及折讓(進貨及費用)-專供免稅不得扣抵 */
isca507       number(20,6)      ,/* 退出及折讓(固定資產)-進項稅額合計(代號43) */
isca508       number(20,6)      ,/* 退出及折讓(固定資產)-專供課稅得扣抵 */
isca509       number(20,6)      ,/* 退出及折讓(固定資產)-共同使用-小計 */
isca510       number(20,6)      ,/* 退出及折讓(固定資產)-共同使用-比例得扣抵 */
isca511       number(20,6)      ,/* 退出及折讓(固定資產)-共同使用-比例不得扣抵 */
isca512       number(20,6)      ,/* 退出及折讓(固定資產)-專供免稅不得扣抵 */
isca601       number(20,6)      ,/* 合計(進貨及費用)-進項稅額合計(代號45) */
isca602       number(20,6)      ,/* 合計(進貨及費用)-專供課稅得扣抵 */
isca603       number(20,6)      ,/* 合計(進貨及費用)-共同使用-小計 */
isca604       number(20,6)      ,/* 合計(進貨及費用)-共同使用-比例得扣抵 */
isca605       number(20,6)      ,/* 合計(進貨及費用)-共同使用-比例不得扣抵 */
isca606       number(20,6)      ,/* 合計(進貨及費用)-專供免稅不得扣抵 */
isca607       number(20,6)      ,/* 合計(固定資產)-進項稅額合計(代號47) */
isca608       number(20,6)      ,/* 合計(固定資產)-專供課稅得扣抵 */
isca609       number(20,6)      ,/* 合計(固定資產)-共同使用-小計 */
isca610       number(20,6)      ,/* 合計(固定資產)-共同使用-比例得扣抵 */
isca611       number(20,6)      ,/* 合計(固定資產)-共同使用-比例不得扣抵 */
isca612       number(20,6)      ,/* 合計(固定資產)-專供免稅不得扣抵 */
isca701       number(20,6)      ,/* 國外勞務-合計(代號74) */
isca702       number(20,6)      ,/* 國外勞務-免稅 */
isca703       number(20,6)      ,/* 國外勞務-共同使用 */
isca704       number(20,6)      ,/* 國外勞務-課稅 */
isca705       number(20,6)      ,/* 國外勞務-免稅(b) */
isca706       number(20,6)      ,/* 國外勞務-免稅(c) */
isca707       number(20,6)      ,/* 國外勞務-共同使用(e) */
isca708       number(20,6)      ,/* 國外勞務-共同使用(f) */
isca801       number(20,6)      ,/* 應納稅額-免稅(h) */
isca802       number(20,6)      ,/* 應納稅額-免稅(i) */
isca803       number(20,6)      ,/* 應納稅額-共同使用(k) */
isca804       number(20,6)      ,/* 應納稅額-共同使用(l) */
isca805       number(20,6)      ,/* 應納稅額-合計(代號76) */
isca806       number(20,6)      ,/* 應納稅額-免稅 */
isca807       number(20,6)      ,/* 應納稅額-共同使用 */
isca808       number(20,6)      ,/* 得扣抵之進項稅額合計(代號51) */
isca809       number(20,6)      ,/* 不得扣抵比例 */
iscaownid       varchar2(20)      ,/* 資料所有者 */
iscaowndp       varchar2(10)      ,/* 資料所屬部門 */
iscacrtid       varchar2(20)      ,/* 資料建立者 */
iscacrtdp       varchar2(10)      ,/* 資料建立部門 */
iscacrtdt       timestamp(0)      ,/* 資料創建日 */
iscamodid       varchar2(20)      ,/* 資料修改者 */
iscamoddt       timestamp(0)      ,/* 最近修改日 */
iscacnfid       varchar2(20)      ,/* 資料確認者 */
iscacnfdt       timestamp(0)      ,/* 資料確認日 */
iscapstid       varchar2(20)      ,/* 資料過帳者 */
iscapstdt       timestamp(0)      ,/* 資料過帳日 */
iscastus       varchar2(10)      ,/* 狀態碼 */
iscaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
iscaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
iscaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
iscaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
iscaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
iscaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
iscaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
iscaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
iscaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
iscaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
iscaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
iscaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
iscaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
iscaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
iscaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
iscaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
iscaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
iscaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
iscaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
iscaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
iscaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
iscaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
iscaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
iscaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
iscaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
iscaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
iscaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
iscaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
iscaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
iscaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isca_t add constraint isca_pk primary key (iscaent,iscasite,isca001,isca002) enable validate;

create unique index isca_pk on isca_t (iscaent,iscasite,isca001,isca002);

grant select on isca_t to tiptop;
grant update on isca_t to tiptop;
grant delete on isca_t to tiptop;
grant insert on isca_t to tiptop;

exit;
