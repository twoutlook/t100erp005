/* 
================================================================================
檔案代號:mmcb_t
檔案名稱:生效營運據點卡積點進階規則單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mmcb_t
(
mmcbent       number(5)      ,/* 企業編號 */
mmcbsite       varchar2(10)      ,/* 營運據點 */
mmcb001       varchar2(20)      ,/* 活動規則編號 */
mmcb002       varchar2(10)      ,/* 卡種編號 */
mmcb003       varchar2(10)      ,/* 進階規則類型 */
mmcb004       varchar2(10)      ,/* 進階規則編碼 */
mmcb005       varchar2(1)      ,/* 互斥 */
mmcb006       number(10,0)      ,/* 優先序 */
mmcb007       varchar2(10)      ,/* 紀念日回饋條件 */
mmcb008       number(5,0)      ,/* 紀念日前(日) */
mmcb009       number(5,0)      ,/* 紀念日後(日) */
mmcb010       varchar2(10)      ,/* 回饋類型 */
mmcb011       number(5,0)      ,/* 加送倍數 */
mmcb012       number(20,6)      ,/* 回饋基點基準 */
mmcb013       number(15,3)      ,/* 加送積點 */
mmcb014       date      ,/* 生效日期 */
mmcb015       date      ,/* 失效日期 */
mmcb016       varchar2(8)      ,/* 每日開始時間 */
mmcb017       varchar2(8)      ,/* 每日結束時間 */
mmcb018       varchar2(10)      ,/* 固定日期 */
mmcb019       varchar2(1)      ,/* 固定星期 */
mmcbacti       varchar2(1)      ,/* 資料有效 */
mmcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcb_t add constraint mmcb_pk primary key (mmcbent,mmcbsite,mmcb001,mmcb003,mmcb004) enable validate;

create unique index mmcb_pk on mmcb_t (mmcbent,mmcbsite,mmcb001,mmcb003,mmcb004);

grant select on mmcb_t to tiptop;
grant update on mmcb_t to tiptop;
grant delete on mmcb_t to tiptop;
grant insert on mmcb_t to tiptop;

exit;
