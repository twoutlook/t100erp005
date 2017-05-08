/* 
================================================================================
檔案代號:mmcn_t
檔案名稱:換贈生效時段單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mmcn_t
(
mmcnent       number(5)      ,/* 企業編號 */
mmcn001       varchar2(20)      ,/* 活動規則編號 */
mmcn002       varchar2(10)      ,/* 卡種編號 */
mmcn003       number(10,0)      ,/* 時段序 */
mmcn004       date      ,/* 開始日期 */
mmcn005       date      ,/* 結束日期 */
mmcn006       varchar2(8)      ,/* 每日開始時間 */
mmcn007       varchar2(8)      ,/* 每日結束時間 */
mmcn008       varchar2(10)      ,/* 固定日期 */
mmcn009       varchar2(10)      ,/* 固定星期 */
mmcnstus       varchar2(1)      ,/* 有效 */
mmcnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcn_t add constraint mmcn_pk primary key (mmcnent,mmcn001,mmcn003) enable validate;

create unique index mmcn_pk on mmcn_t (mmcnent,mmcn001,mmcn003);

grant select on mmcn_t to tiptop;
grant update on mmcn_t to tiptop;
grant delete on mmcn_t to tiptop;
grant insert on mmcn_t to tiptop;

exit;
