/* 
================================================================================
檔案代號:prbs_t
檔案名稱:生鮮品類配置資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table prbs_t
(
prbsent       number(5)      ,/* 企業代碼 */
prbs001       varchar2(10)      ,/* 生鮮品類 */
prbsstus       varchar2(10)      ,/* 狀態碼 */
prbsownid       varchar2(20)      ,/* 資料所有者 */
prbsowndp       varchar2(10)      ,/* 資料所屬部門 */
prbscrtid       varchar2(20)      ,/* 資料建立者 */
prbscrtdp       varchar2(10)      ,/* 資料建立部門 */
prbscrtdt       timestamp(0)      ,/* 資料創建日 */
prbsmodid       varchar2(20)      ,/* 資料修改者 */
prbsmoddt       timestamp(0)      ,/* 最近修改日 */
prbsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prbs_t add constraint prbs_pk primary key (prbsent,prbs001) enable validate;

create unique index prbs_pk on prbs_t (prbsent,prbs001);

grant select on prbs_t to tiptop;
grant update on prbs_t to tiptop;
grant delete on prbs_t to tiptop;
grant insert on prbs_t to tiptop;

exit;
