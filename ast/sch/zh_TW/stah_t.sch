/* 
================================================================================
檔案代號:stah_t
檔案名稱:自營合約模板費用設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stah_t
(
stahent       number(5)      ,/* 企業編號 */
stah001       varchar2(10)      ,/* 模板編號 */
stah002       number(10,0)      ,/* 序號 */
stah003       varchar2(10)      ,/* 費用編號 */
stah004       varchar2(10)      ,/* 會計期間 */
stah005       varchar2(10)      ,/* 價款類別 */
stah006       varchar2(10)      ,/* 計算類型 */
stah007       varchar2(10)      ,/* 費用週期 */
stah008       varchar2(10)      ,/* 費用週期方式 */
stah009       varchar2(10)      ,/* 條件基準 */
stah010       varchar2(10)      ,/* 計算基準 */
stah011       number(20,6)      ,/* 費用淨額 */
stah012       number(20,6)      ,/* 費用比率 */
stah013       varchar2(10)      ,/* 保底 */
stah014       number(20,6)      ,/* 保底金額 */
stah015       number(20,6)      ,/* 保底扣率 */
stah016       varchar2(10)      ,/* 分量扣點 */
stahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stahud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stah017       varchar2(1)      /* 是否參與現金折扣 */
);
alter table stah_t add constraint stah_pk primary key (stahent,stah001,stah002) enable validate;

create unique index stah_pk on stah_t (stahent,stah001,stah002);

grant select on stah_t to tiptop;
grant update on stah_t to tiptop;
grant delete on stah_t to tiptop;
grant insert on stah_t to tiptop;

exit;
