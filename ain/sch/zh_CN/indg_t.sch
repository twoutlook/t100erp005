/* 
================================================================================
檔案代號:indg_t
檔案名稱:報損報溢單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table indg_t
(
indgent       number(5)      ,/* 企業編號 */
indgsite       varchar2(10)      ,/* 營運據點 */
indgunit       varchar2(10)      ,/* 應用組織 */
indgdocno       varchar2(20)      ,/* 單據編號 */
indgdocdt       date      ,/* 單據日期 */
indg001       varchar2(20)      ,/* 人員 */
indg002       varchar2(10)      ,/* 管理品類 */
indg003       varchar2(10)      ,/* 單據類別 */
indg004       varchar2(255)      ,/* 備註 */
indgownid       varchar2(20)      ,/* 資料所有者 */
indgowndp       varchar2(10)      ,/* 資料所屬部門 */
indgcrtid       varchar2(20)      ,/* 資料建立者 */
indgcrtdp       varchar2(10)      ,/* 資料建立部門 */
indgcrtdt       timestamp(0)      ,/* 資料創建日 */
indgmodid       varchar2(20)      ,/* 資料修改者 */
indgmoddt       timestamp(0)      ,/* 最近修改日 */
indgcnfid       varchar2(20)      ,/* 資料確認者 */
indgcnfdt       timestamp(0)      ,/* 資料確認日 */
indgpstid       varchar2(20)      ,/* 資料過帳者 */
indgpstdt       timestamp(0)      ,/* 資料過帳日 */
indgstus       varchar2(10)      ,/* 狀態碼 */
indgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table indg_t add constraint indg_pk primary key (indgent,indgdocno) enable validate;

create unique index indg_pk on indg_t (indgent,indgdocno);

grant select on indg_t to tiptop;
grant update on indg_t to tiptop;
grant delete on indg_t to tiptop;
grant insert on indg_t to tiptop;

exit;
