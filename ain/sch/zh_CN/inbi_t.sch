/* 
================================================================================
檔案代號:inbi_t
檔案名稱:庫存報廢單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inbi_t
(
inbient       number(5)      ,/* 企業編號 */
inbisite       varchar2(10)      ,/* 營運據點 */
inbidocno       varchar2(20)      ,/* 單據編號 */
inbidocdt       date      ,/* 輸入日期 */
inbi000       varchar2(1)      ,/* 單據類別 */
inbi001       varchar2(20)      ,/* 申請人員 */
inbi002       varchar2(10)      ,/* 申請部門 */
inbi003       varchar2(10)      ,/* 報廢原因 */
inbi004       varchar2(1)      ,/* 檢驗否 */
inbi005       varchar2(10)      ,/* 在途成本庫位 */
inbi006       varchar2(10)      ,/* 在途非成本庫位 */
inbi007       date      ,/* 申請確認日期 */
inbi008       date      ,/* 報廢確認日期 */
inbi009       varchar2(20)      ,/* 調撥單號 */
inbi021       varchar2(255)      ,/* 備註 */
inbi031       varchar2(20)      ,/* 報廢申請單號 */
inbi032       varchar2(1)      ,/* 報廢品做庫存管理 */
inbiownid       varchar2(20)      ,/* 資料所有者 */
inbiowndp       varchar2(10)      ,/* 資料所屬部門 */
inbicrtid       varchar2(20)      ,/* 資料建立者 */
inbicrtdp       varchar2(10)      ,/* 資料建立部門 */
inbicrtdt       timestamp(0)      ,/* 資料創建日 */
inbimodid       varchar2(20)      ,/* 資料修改者 */
inbimoddt       timestamp(0)      ,/* 最近修改日 */
inbicnfid       varchar2(20)      ,/* 資料確認者 */
inbicnfdt       timestamp(0)      ,/* 資料確認日 */
inbipstid       varchar2(20)      ,/* 資料過帳者 */
inbipstdt       timestamp(0)      ,/* 資料過帳日 */
inbistus       varchar2(10)      ,/* 狀態碼 */
inbiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inbiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inbiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inbiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inbiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inbiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inbiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inbiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inbiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inbiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inbiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inbiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inbiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inbiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inbiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inbiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inbiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inbiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inbiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inbiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inbiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inbiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inbiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inbiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inbiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inbiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inbiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inbiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inbiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inbiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inbi_t add constraint inbi_pk primary key (inbient,inbidocno) enable validate;

create unique index inbi_pk on inbi_t (inbient,inbidocno);

grant select on inbi_t to tiptop;
grant update on inbi_t to tiptop;
grant delete on inbi_t to tiptop;
grant insert on inbi_t to tiptop;

exit;
