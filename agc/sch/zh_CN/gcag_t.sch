/* 
================================================================================
檔案代號:gcag_t
檔案名稱:券種基本資料檔-折價券收券限制條件設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gcag_t
(
gcagent       number(5)      ,/* 企業編號 */
gcag001       varchar2(10)      ,/* 券種編碼 */
gcag002       number(10,0)      ,/* 序 */
gcag003       varchar2(10)      ,/* 消費數量滿/ 額滿 */
gcag004       number(20,6)      ,/* 單位消費金額/ 數量 */
gcag005       number(20,6)      ,/* 單位收券金額 */
gcag006       number(20,6)      ,/* 收券金額上限 */
gcagstus       varchar2(1)      ,/* 有效 */
gcagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcag_t add constraint gcag_pk primary key (gcagent,gcag001,gcag002) enable validate;

create unique index gcag_pk on gcag_t (gcagent,gcag001,gcag002);

grant select on gcag_t to tiptop;
grant update on gcag_t to tiptop;
grant delete on gcag_t to tiptop;
grant insert on gcag_t to tiptop;

exit;
