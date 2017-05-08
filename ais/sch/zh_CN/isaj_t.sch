/* 
================================================================================
檔案代號:isaj_t
檔案名稱:媒體申報資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table isaj_t
(
isajent       number(5)      ,/* 企業編號 */
isajcomp       varchar2(10)      ,/* 法人編碼 */
isajsite       varchar2(10)      ,/* 營運據點 */
isajdocdt       date      ,/* 資料日期 */
isaj001       varchar2(1)      ,/* 來源類別 */
isaj002       varchar2(20)      ,/* 發票來源單號 */
isaj003       varchar2(10)      ,/* 申報單位 */
isaj004       varchar2(2)      ,/* 發票類型 */
isaj005       varchar2(20)      ,/* 發票代碼 */
isaj006       varchar2(20)      ,/* 發票號碼 */
isaj007       number(10,0)      ,/* 流水號 */
isaj008       varchar2(20)      ,/* 海關代徵營業稅繳納證號 */
isaj009       date      ,/* 發票日期 */
isaj010       varchar2(20)      ,/* 銷貨方統一編號 */
isaj011       varchar2(20)      ,/* 銷貨方稅務編號 */
isaj012       varchar2(20)      ,/* 購貨方統一編號 */
isaj013       varchar2(20)      ,/* 購貨方稅務編號 */
isaj014       varchar2(1)      ,/* 扣抵代號 */
isaj015       varchar2(1)      ,/* 課稅別 */
isaj016       number(5,2)      ,/* 稅率 */
isaj017       varchar2(1)      ,/* 彙加註記 */
isaj018       varchar2(10)      ,/* 申報格式 */
isaj019       number(5,0)      ,/* 申報年度 */
isaj020       number(5,0)      ,/* 申報月份 */
isaj021       varchar2(10)      ,/* 客戶代碼 */
isaj022       date      ,/* 結關日期 */
isaj023       varchar2(10)      ,/* 外銷方式 */
isaj024       varchar2(10)      ,/* 通關方式 */
isaj025       varchar2(40)      ,/* 非經海關證明文件名稱 */
isaj026       varchar2(20)      ,/* 非經海關證明文件號碼 */
isaj027       varchar2(10)      ,/* 經由海關出口報單類別 */
isaj028       varchar2(40)      ,/* 出口報單號碼 */
isaj029       varchar2(1)      ,/* 電子發票否 */
isaj030       varchar2(10)      ,/* 異動狀態 */
isaj103       number(20,10)      ,/* 未稅金額 */
isaj104       number(20,6)      ,/* 稅額 */
isaj105       number(20,6)      ,/* 含稅金額 */
isajstus       varchar2(1)      ,/* 狀態碼 */
isajownid       varchar2(20)      ,/* 資料所有者 */
isajowndp       varchar2(10)      ,/* 資料所屬部門 */
isajcrtid       varchar2(20)      ,/* 資料建立者 */
isajcrtdp       varchar2(10)      ,/* 資料建立部門 */
isajcrtdt       timestamp(0)      ,/* 資料創建日 */
isajmodid       varchar2(20)      ,/* 資料修改者 */
isajmoddt       timestamp(0)      ,/* 最近修改日 */
isajcnfid       varchar2(20)      ,/* 資料確認者 */
isajcnfdt       timestamp(0)      ,/* 資料確認日 */
isajpstid       varchar2(20)      ,/* 資料過帳者 */
isajpstdt       timestamp(0)      ,/* 資料過帳日 */
isajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isajud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
isaj031       varchar2(10)      ,/* 發票簿號 */
isaj032       varchar2(1)      ,/* 銷售固資 */
isaj033       varchar2(1)      ,/* 進銷項類型 */
isaj034       varchar2(255)      ,/* 買受人名稱 */
isaj035       varchar2(255)      ,/* 貨物勞務名稱 */
isaj036       number(15,3)      ,/* 貨物勞務數量 */
isaj037       varchar2(20)      ,/* 傳票號碼 */
isaj038       number(10,0)      /* 發票張數 */
);
alter table isaj_t add constraint isaj_pk primary key (isajent,isajcomp,isajsite,isaj001,isaj003,isaj005,isaj006,isaj007,isaj019,isaj020) enable validate;

create unique index isaj_pk on isaj_t (isajent,isajcomp,isajsite,isaj001,isaj003,isaj005,isaj006,isaj007,isaj019,isaj020);

grant select on isaj_t to tiptop;
grant update on isaj_t to tiptop;
grant delete on isaj_t to tiptop;
grant insert on isaj_t to tiptop;

exit;
