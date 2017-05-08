/* 
================================================================================
檔案代號:apac_t
檔案名稱:零用金帳戶主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table apac_t
(
apacent       number(5)      ,/* 企業編號 */
apacstus       varchar2(10)      ,/* 狀態碼 */
apacsite       varchar2(10)      ,/* 歸屬營運據點 */
apac001       varchar2(10)      ,/* 零用金帳戶代碼 */
apac002       date      ,/* 設置日期 */
apac003       varchar2(20)      ,/* 管理歸屬人員 */
apac004       varchar2(10)      ,/* 管理歸屬部門 */
apac005       varchar2(10)      ,/* 歸屬帳務組織 */
apac006       varchar2(40)      ,/* 收支表應報告日期 */
apac007       number(20,6)      ,/* 換算本幣留存上限金額 */
apacownid       varchar2(20)      ,/* 資料所有者 */
apacowndp       varchar2(10)      ,/* 資料所屬部門 */
apaccrtid       varchar2(20)      ,/* 資料建立者 */
apaccrtdp       varchar2(10)      ,/* 資料建立部門 */
apaccrtdt       timestamp(0)      ,/* 資料創建日 */
apacmodid       varchar2(20)      ,/* 資料修改者 */
apacmoddt       timestamp(0)      ,/* 最近修改日 */
apacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apac_t add constraint apac_pk primary key (apacent,apac001) enable validate;

create unique index apac_pk on apac_t (apacent,apac001);

grant select on apac_t to tiptop;
grant update on apac_t to tiptop;
grant delete on apac_t to tiptop;
grant insert on apac_t to tiptop;

exit;
