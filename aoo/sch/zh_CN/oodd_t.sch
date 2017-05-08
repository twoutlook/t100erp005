/* 
================================================================================
檔案代號:oodd_t
檔案名稱:交易分類稅別主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oodd_t
(
ooddent       number(5)      ,/* 企業編號 */
oodd001       varchar2(10)      ,/* 交易稅區 */
oodd002       varchar2(1)      ,/* 交易類型 */
ooddseq       number(10,0)      ,/* 項次 */
oodd003       varchar2(10)      ,/* 產品分類碼 */
oodd004       varchar2(40)      ,/* 料件代碼 */
oodd005       varchar2(10)      ,/* 交易對象代碼 */
oodd006       varchar2(10)      ,/* 客戶分類/供應商分類 */
oodd007       varchar2(10)      ,/* 銷售分類/採購分類 */
oodd008       varchar2(10)      ,/* 稅別代碼 */
ooddownid       varchar2(20)      ,/* 資料所有者 */
ooddowndp       varchar2(10)      ,/* 資料所屬部門 */
ooddcrtid       varchar2(20)      ,/* 資料建立者 */
ooddcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooddcrtdt       timestamp(0)      ,/* 資料創建日 */
ooddmodid       varchar2(20)      ,/* 資料修改者 */
ooddmoddt       timestamp(0)      ,/* 最近修改日 */
ooddstus       varchar2(10)      ,/* 狀態碼 */
ooddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooddud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oodd_t add constraint oodd_pk primary key (ooddent,oodd001,oodd002,ooddseq) enable validate;

create unique index oodd_pk on oodd_t (ooddent,oodd001,oodd002,ooddseq);

grant select on oodd_t to tiptop;
grant update on oodd_t to tiptop;
grant delete on oodd_t to tiptop;
grant insert on oodd_t to tiptop;

exit;
