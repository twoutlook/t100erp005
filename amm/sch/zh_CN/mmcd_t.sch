/* 
================================================================================
檔案代號:mmcd_t
檔案名稱:卡儲值加值進階規則申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmcd_t
(
mmcdent       number(5)      ,/* 企業編號 */
mmcdsite       varchar2(10)      ,/* 營運據點 */
mmcdunit       varchar2(10)      ,/* 應用組織 */
mmcddocno       varchar2(20)      ,/* 單據編號 */
mmcd001       varchar2(20)      ,/* 活動規則編號 */
mmcd002       varchar2(10)      ,/* 卡種編號 */
mmcd003       varchar2(10)      ,/* 進階規則類型 */
mmcd004       varchar2(10)      ,/* 進階規則編碼 */
mmcd005       varchar2(1)      ,/* 互斥 */
mmcd006       number(10,0)      ,/* 優先序 */
mmcd007       varchar2(10)      ,/* 紀念日回饋條件 */
mmcd008       number(5,0)      ,/* 紀念日前(日) */
mmcd009       number(5,0)      ,/* 紀念日後(日) */
mmcd010       varchar2(10)      ,/* 進階加值類型 */
mmcd011       number(5,0)      ,/* 加送倍數 */
mmcd012       number(20,6)      ,/* 回饋加值基準 */
mmcd013       number(20,6)      ,/* 加值金額 */
mmcd014       date      ,/* 開始日期 */
mmcd015       date      ,/* 結束日期 */
mmcd016       varchar2(8)      ,/* 每日開始時間 */
mmcd017       varchar2(8)      ,/* 每日結束時間 */
mmcd018       varchar2(10)      ,/* 固定日期 */
mmcd019       varchar2(1)      ,/* 固定星期 */
mmcdacti       varchar2(1)      ,/* 有效 */
mmcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcd_t add constraint mmcd_pk primary key (mmcdent,mmcddocno,mmcd003,mmcd004) enable validate;

create unique index mmcd_pk on mmcd_t (mmcdent,mmcddocno,mmcd003,mmcd004);

grant select on mmcd_t to tiptop;
grant update on mmcd_t to tiptop;
grant delete on mmcd_t to tiptop;
grant insert on mmcd_t to tiptop;

exit;
