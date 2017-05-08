/* 
================================================================================
檔案代號:gzyb_t
檔案名稱:職能角色定義運行作業表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzyb_t
(
gzybent       number(5)      ,/* 企業編號 */
gzyb001       varchar2(10)      ,/* 職能角色編號 */
gzyb002       varchar2(20)      ,/* 作業編號 */
gzybownid       varchar2(20)      ,/* 資料所有者 */
gzybowndp       varchar2(10)      ,/* 資料所屬部門 */
gzybcrtid       varchar2(20)      ,/* 資料建立者 */
gzybcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzybcrtdt       timestamp(0)      ,/* 資料創建日 */
gzybmodid       varchar2(20)      ,/* 資料修改者 */
gzybmoddt       timestamp(0)      ,/* 最近修改日 */
gzybstus       varchar2(10)      ,/* 狀態碼 */
gzyb003       varchar2(1)      ,/* 部門資料授權 */
gzyb004       varchar2(1)      ,/* 個人資料授權 */
gzyb005       varchar2(1)      ,/* 單身處理方式 */
gzyb006       varchar2(1)      ,/* 單據日期控管方式 */
gzyb007       varchar2(1)      ,/* 扣帳日期控管方式 */
gzybud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzybud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzybud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzybud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzybud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzybud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzybud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzybud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzybud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzybud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzybud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzybud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzybud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzybud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzybud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzybud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzybud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzybud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzybud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzybud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzybud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzybud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzybud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzybud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzybud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzybud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzybud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzybud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzybud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzybud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzyb_t add constraint gzyb_pk primary key (gzybent,gzyb001,gzyb002) enable validate;

create unique index gzyb_pk on gzyb_t (gzybent,gzyb001,gzyb002);

grant select on gzyb_t to tiptop;
grant update on gzyb_t to tiptop;
grant delete on gzyb_t to tiptop;
grant insert on gzyb_t to tiptop;

exit;
