/* 
================================================================================
檔案代號:glab_t
檔案名稱:帳套應用會計科目設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table glab_t
(
glabent       number(5)      ,/* 企業編號 */
glabld       varchar2(5)      ,/* 帳套 */
glab001       varchar2(10)      ,/* 設定類型 */
glab002       varchar2(10)      ,/* 分類碼 */
glab003       varchar2(10)      ,/* 分類碼值 */
glab004       varchar2(10)      ,/* 科目參照表編號 */
glab005       varchar2(24)      ,/* 會計科目編號一 */
glab006       varchar2(24)      ,/* 會計科目編號二 */
glab007       varchar2(24)      ,/* 會計科目編號三 */
glab008       varchar2(24)      ,/* 會計科目編號四 */
glab009       varchar2(24)      ,/* 會計科目編號五 */
glab010       varchar2(100)      ,/* 其他設定值 */
glab011       varchar2(10)      ,/* 科目彙總方式 */
glabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glabud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
glab012       varchar2(24)      ,/* 会计科目编号六 */
glab013       varchar2(24)      ,/* 會計科目編號七 */
glab014       varchar2(10)      ,/* 代收銀據點 */
glab015       varchar2(5)      ,/* 據點帳套 */
glab016       varchar2(24)      /* 代收銀收款科目(流通) */
);
alter table glab_t add constraint glab_pk primary key (glabent,glabld,glab001,glab002,glab003) enable validate;

create  index glab_01 on glab_t (glab005);
create  index glab_02 on glab_t (glab006);
create  index glab_03 on glab_t (glab007);
create unique index glab_pk on glab_t (glabent,glabld,glab001,glab002,glab003);

grant select on glab_t to tiptop;
grant update on glab_t to tiptop;
grant delete on glab_t to tiptop;
grant insert on glab_t to tiptop;

exit;
