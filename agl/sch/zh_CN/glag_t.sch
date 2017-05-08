/* 
================================================================================
檔案代號:glag_t
檔案名稱:自由核算項彈性預設檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glag_t
(
glagent       number(5)      ,/* 企業編號 */
glagownid       varchar2(20)      ,/* 資料所有者 */
glagowndp       varchar2(10)      ,/* 資料所屬部門 */
glagcrtid       varchar2(20)      ,/* 資料建立者 */
glagcrtdp       varchar2(10)      ,/* 資料建立部門 */
glagcrtdt       timestamp(0)      ,/* 資料創建日 */
glagmodid       varchar2(20)      ,/* 資料修改者 */
glagmoddt       timestamp(0)      ,/* 最近修改日 */
glagstus       varchar2(10)      ,/* 狀態碼 */
glagld       varchar2(5)      ,/* 帳別編號 */
glag001       varchar2(24)      ,/* 科目編號 */
glag002       varchar2(20)      ,/* 交易作業編號 */
glag003       varchar2(10)      ,/* 目的欄位 */
glag004       varchar2(20)      ,/* 來源欄位 */
glag005       number(10,0)      ,/* 來源項次 */
glagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glag_t add constraint glag_pk primary key (glagent,glagld,glag001,glag002,glag003) enable validate;

create unique index glag_pk on glag_t (glagent,glagld,glag001,glag002,glag003);

grant select on glag_t to tiptop;
grant update on glag_t to tiptop;
grant delete on glag_t to tiptop;
grant insert on glag_t to tiptop;

exit;
