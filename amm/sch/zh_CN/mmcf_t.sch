/* 
================================================================================
檔案代號:mmcf_t
檔案名稱:卡儲值加值進階規則單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmcf_t
(
mmcfent       number(5)      ,/* 企業編號 */
mmcf001       varchar2(20)      ,/* 活動規則編號 */
mmcf002       varchar2(10)      ,/* 卡種編號 */
mmcf003       varchar2(10)      ,/* 進階規則類型 */
mmcf004       varchar2(10)      ,/* 進階規則編碼 */
mmcf005       varchar2(1)      ,/* 互斥 */
mmcf006       number(10,0)      ,/* 優先序 */
mmcf007       varchar2(10)      ,/* 紀念日回饋條件 */
mmcf008       number(5,0)      ,/* 紀念日前(日) */
mmcf009       number(5,0)      ,/* 紀念日後(日) */
mmcf010       varchar2(10)      ,/* 進階加值類型 */
mmcf011       number(5,0)      ,/* 加送倍數 */
mmcf012       number(20,6)      ,/* 回饋加值基準 */
mmcf013       number(20,6)      ,/* 加值金額 */
mmcf014       date      ,/* 開始日期 */
mmcf015       date      ,/* 結束日期 */
mmcf016       varchar2(8)      ,/* 每日開始時間 */
mmcf017       varchar2(8)      ,/* 每日結束時間 */
mmcf018       varchar2(10)      ,/* 固定日期 */
mmcf019       varchar2(1)      ,/* 固定星期 */
mmcfstus       varchar2(1)      ,/* 資料有效 */
mmcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcf_t add constraint mmcf_pk primary key (mmcfent,mmcf001,mmcf003,mmcf004) enable validate;

create unique index mmcf_pk on mmcf_t (mmcfent,mmcf001,mmcf003,mmcf004);

grant select on mmcf_t to tiptop;
grant update on mmcf_t to tiptop;
grant delete on mmcf_t to tiptop;
grant insert on mmcf_t to tiptop;

exit;
