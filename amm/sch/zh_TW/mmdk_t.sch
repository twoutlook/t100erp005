/* 
================================================================================
檔案代號:mmdk_t
檔案名稱:高端規則對應日期範圍主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmdk_t
(
mmdkent       number(5)      ,/* 企業編號 */
mmdkacti       varchar2(1)      ,/* 資料有效 */
mmdksite       varchar2(10)      ,/* 營運組織 */
mmdkunit       varchar2(10)      ,/* 應用組織 */
mmdk001       varchar2(20)      ,/* 活動規則編號 */
mmdk002       varchar2(10)      ,/* 規則對象編號 */
mmdk003       varchar2(10)      ,/* 高端規則類型 */
mmdk004       varchar2(10)      ,/* 高端規則編號 */
mmdk005       number(10,0)      ,/* 項次 */
mmdk006       date      ,/* 開始日期 */
mmdk007       date      ,/* 結束日期 */
mmdk008       varchar2(8)      ,/* 每日開始時間 */
mmdk009       varchar2(8)      ,/* 每日結束時間 */
mmdk010       varchar2(10)      ,/* 固定日期 */
mmdk011       varchar2(10)      ,/* 固定星期 */
mmdkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmdkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmdkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmdkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmdkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmdkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmdkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmdkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmdkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmdkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmdkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmdkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmdkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmdkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmdkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmdkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmdkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmdkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmdkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmdkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmdkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmdkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmdkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmdkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmdkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmdkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmdkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmdkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmdkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmdkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmdk_t add constraint mmdk_pk primary key (mmdkent,mmdk001,mmdk003,mmdk004,mmdk005) enable validate;

create unique index mmdk_pk on mmdk_t (mmdkent,mmdk001,mmdk003,mmdk004,mmdk005);

grant select on mmdk_t to tiptop;
grant update on mmdk_t to tiptop;
grant delete on mmdk_t to tiptop;
grant insert on mmdk_t to tiptop;

exit;
