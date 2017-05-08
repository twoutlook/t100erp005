/* 
================================================================================
檔案代號:mmcw_t
檔案名稱:會員等級升降策略卡種範圍設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmcw_t
(
mmcwent       number(5)      ,/* 企業編號 */
mmcw001       varchar2(30)      ,/* 升降等策略編號 */
mmcw002       varchar2(10)      ,/* 卡種編號 */
mmcwstus       varchar2(1)      ,/* 資料有效 */
mmcwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcw_t add constraint mmcw_pk primary key (mmcwent,mmcw001,mmcw002) enable validate;

create unique index mmcw_pk on mmcw_t (mmcwent,mmcw001,mmcw002);

grant select on mmcw_t to tiptop;
grant update on mmcw_t to tiptop;
grant delete on mmcw_t to tiptop;
grant insert on mmcw_t to tiptop;

exit;
