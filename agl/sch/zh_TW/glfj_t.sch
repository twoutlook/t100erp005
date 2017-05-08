/* 
================================================================================
檔案代號:glfj_t
檔案名稱:合併報表聯屬公司持股比例檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table glfj_t
(
glfjent       number(5)      ,/* 企業代碼 */
glfjld       varchar2(5)      ,/* 合併帳套 */
glfj001       varchar2(10)      ,/* 上層公司 */
glfj002       varchar2(5)      ,/* 上層公司帳套 */
glfj003       varchar2(10)      ,/* 下層公司 */
glfj004       varchar2(5)      ,/* 下層公司帳套 */
glfj005       number(20,6)      ,/* 持股比率% */
glfj006       varchar2(1)      ,/* 納入合併否 */
glfj007       number(10,0)      ,/* 投資股數 */
glfj008       number(20,6)      ,/* 股本 */
glfj009       date      ,/* 異動日期 */
glfjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glfjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glfjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glfjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glfjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glfjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glfjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glfjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glfjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glfjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glfjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glfjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glfjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glfjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glfjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glfjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glfjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glfjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glfjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glfjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glfjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glfjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glfjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glfjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glfjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glfjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glfjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glfjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glfjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glfjud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
glfj010       varchar2(1)      /* 異動類型 */
);
alter table glfj_t add constraint glfj_pk primary key (glfjent,glfjld,glfj001,glfj002,glfj003,glfj004,glfj009,glfj010) enable validate;

create unique index glfj_pk on glfj_t (glfjent,glfjld,glfj001,glfj002,glfj003,glfj004,glfj009,glfj010);

grant select on glfj_t to tiptop;
grant update on glfj_t to tiptop;
grant delete on glfj_t to tiptop;
grant insert on glfj_t to tiptop;

exit;
