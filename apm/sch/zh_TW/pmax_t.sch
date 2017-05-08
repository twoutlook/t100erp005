/* 
================================================================================
檔案代號:pmax_t
檔案名稱:經銷商經營主品牌檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmax_t
(
pmaxent       number(5)      ,/* 企業編號 */
pmax001       varchar2(10)      ,/* 交易對象編號 */
pmax002       varchar2(10)      ,/* 商品品類 */
pmax003       varchar2(10)      ,/* 商品品牌 */
pmaxstus       varchar2(10)      ,/* 狀態碼 */
pmaxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmaxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmaxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmaxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmaxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmaxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmaxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmaxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmaxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmaxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmaxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmaxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmaxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmaxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmaxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmaxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmaxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmaxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmaxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmaxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmaxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmaxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmaxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmaxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmaxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmaxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmaxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmaxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmaxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmaxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmax_t add constraint pmax_pk primary key (pmaxent,pmax001,pmax002,pmax003) enable validate;

create unique index pmax_pk on pmax_t (pmaxent,pmax001,pmax002,pmax003);

grant select on pmax_t to tiptop;
grant update on pmax_t to tiptop;
grant delete on pmax_t to tiptop;
grant insert on pmax_t to tiptop;

exit;
