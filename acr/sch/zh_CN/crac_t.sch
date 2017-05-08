/* 
================================================================================
檔案代號:crac_t
檔案名稱:潛在客戶等級變更申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:Y
============.========================.==========================================
 */
create table crac_t
(
cracent       number(5)      ,/* 企業編號 */
cracunit       varchar2(10)      ,/* 應用組織 */
cracsite       varchar2(10)      ,/* 營運據點 */
cracdocno       varchar2(20)      ,/* 單據編號 */
cracdocdt       date      ,/* 單據日期 */
crac001       varchar2(10)      ,/* 潛客編號 */
crac002       varchar2(10)      ,/* 版本 */
crac003       varchar2(10)      ,/* 理由碼 */
crac004       varchar2(10)      ,/* 客戶等級 */
crac005       varchar2(20)      ,/* 業務人員 */
cracstus       varchar2(10)      ,/* 資料狀態碼 */
cracownid       varchar2(20)      ,/* 資料所有者 */
cracowndp       varchar2(10)      ,/* 資料所屬部門 */
craccrtid       varchar2(20)      ,/* 資料建立者 */
craccrtdp       varchar2(10)      ,/* 資料建立部門 */
craccrtdt       timestamp(0)      ,/* 資料創建日 */
cracmodid       varchar2(20)      ,/* 資料修改者 */
cracmoddt       timestamp(0)      ,/* 最近修改日 */
craccnfid       varchar2(20)      ,/* 資料確認者 */
craccnfdt       timestamp(0)      ,/* 資料確認日 */
cracud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
cracud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
cracud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
cracud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
cracud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
cracud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
cracud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
cracud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
cracud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
cracud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
cracud011       number(20,6)      ,/* 自定義欄位(數字)011 */
cracud012       number(20,6)      ,/* 自定義欄位(數字)012 */
cracud013       number(20,6)      ,/* 自定義欄位(數字)013 */
cracud014       number(20,6)      ,/* 自定義欄位(數字)014 */
cracud015       number(20,6)      ,/* 自定義欄位(數字)015 */
cracud016       number(20,6)      ,/* 自定義欄位(數字)016 */
cracud017       number(20,6)      ,/* 自定義欄位(數字)017 */
cracud018       number(20,6)      ,/* 自定義欄位(數字)018 */
cracud019       number(20,6)      ,/* 自定義欄位(數字)019 */
cracud020       number(20,6)      ,/* 自定義欄位(數字)020 */
cracud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
cracud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
cracud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
cracud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
cracud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
cracud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
cracud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
cracud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
cracud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
cracud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crac_t add constraint crac_pk primary key (cracent,cracdocno) enable validate;

create unique index crac_pk on crac_t (cracent,cracdocno);

grant select on crac_t to tiptop;
grant update on crac_t to tiptop;
grant delete on crac_t to tiptop;
grant insert on crac_t to tiptop;

exit;
