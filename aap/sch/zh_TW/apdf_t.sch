/* 
================================================================================
檔案代號:apdf_t
檔案名稱:付款資料變更主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table apdf_t
(
apdfent       number(5)      ,/* 企業編號 */
apdfdocno       varchar2(20)      ,/* 申請單號 */
apdfdocdt       date      ,/* 申請日期 */
apdfld       varchar2(5)      ,/* 帳套 */
apdfcomp       varchar2(10)      ,/* 公司別 */
apdfsite       varchar2(10)      ,/* 帳務中心 */
apdf001       varchar2(20)      ,/* 帳務人員 */
apdfstus       varchar2(10)      ,/* 單據狀態 */
apdfownid       varchar2(20)      ,/* 資料所有者 */
apdfowndp       varchar2(10)      ,/* 資料所屬部門 */
apdfcrtid       varchar2(20)      ,/* 資料建立者 */
apdfcrtdp       varchar2(10)      ,/* 資料建立部門 */
apdfcrtdt       timestamp(0)      ,/* 資料創建日 */
apdfmodid       varchar2(20)      ,/* 資料修改者 */
apdfmoddt       timestamp(0)      ,/* 最近修改日 */
apdfcnfid       varchar2(20)      ,/* 資料確認者 */
apdfcnfdt       timestamp(0)      ,/* 資料確認日 */
apdfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apdfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apdfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apdfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apdfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apdfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apdfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apdfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apdfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apdfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apdfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apdfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apdfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apdfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apdfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apdfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apdfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apdfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apdfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apdfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apdfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apdfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apdfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apdfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apdfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apdfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apdfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apdfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apdfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apdfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apdf_t add constraint apdf_pk primary key (apdfent,apdfdocno,apdfld) enable validate;

create unique index apdf_pk on apdf_t (apdfent,apdfdocno,apdfld);

grant select on apdf_t to tiptop;
grant update on apdf_t to tiptop;
grant delete on apdf_t to tiptop;
grant insert on apdf_t to tiptop;

exit;
