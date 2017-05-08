/* 
================================================================================
檔案代號:ooib_t
檔案名稱:收付款條件主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooib_t
(
ooibent       number(5)      ,/* 企業編號 */
ooibownid       varchar2(20)      ,/* 資料所有者 */
ooibowndp       varchar2(10)      ,/* 資料所屬部門 */
ooibcrtid       varchar2(20)      ,/* 資料建立者 */
ooibcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooibcrtdt       timestamp(0)      ,/* 資料創建日 */
ooibmodid       varchar2(20)      ,/* 資料修改者 */
ooibmoddt       timestamp(0)      ,/* 最近修改日 */
ooibstus       varchar2(10)      ,/* 狀態碼 */
ooib001       varchar2(1)      ,/* 收款/付款 */
ooib002       varchar2(10)      ,/* 收付款條件編號 */
ooib004       varchar2(10)      ,/* 款別性質 */
ooib005       varchar2(10)      ,/* 慣用繳款優惠條件 */
ooib006       varchar2(1)      ,/* 訂金收取否 */
ooib007       varchar2(1)      ,/* 現付交易否 */
ooib011       varchar2(10)      ,/* 應收付款起算基準 */
ooib012       number(5,0)      ,/* 應收付款日加(季) */
ooib013       number(5,0)      ,/* 應收付款日加(月) */
ooib014       number(5,0)      ,/* 應收付款日加(日) */
ooib021       varchar2(10)      ,/* 帳款兌現起算基準 */
ooib022       number(5,0)      ,/* 帳款兌現日加(季) */
ooib023       number(5,0)      ,/* 帳款兌現日加(月) */
ooib024       number(5,0)      ,/* 帳款兌現日加(日) */
ooib025       varchar2(10)      ,/* 慣用多帳期類型　 */
ooibud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooibud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooibud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooibud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooibud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooibud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooibud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooibud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooibud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooibud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooibud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooibud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooibud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooibud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooibud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooibud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooibud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooibud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooibud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooibud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooibud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooibud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooibud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooibud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooibud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooibud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooibud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooibud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooibud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooibud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
ooib026       varchar2(1)      /* 尾款性質 */
);
alter table ooib_t add constraint ooib_pk primary key (ooibent,ooib002) enable validate;

create  index ooib_01 on ooib_t (ooib004);
create unique index ooib_pk on ooib_t (ooibent,ooib002);

grant select on ooib_t to tiptop;
grant update on ooib_t to tiptop;
grant delete on ooib_t to tiptop;
grant insert on ooib_t to tiptop;

exit;
