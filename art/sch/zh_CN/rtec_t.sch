/* 
================================================================================
檔案代號:rtec_t
檔案名稱:市場調查計畫明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtec_t
(
rtecent       number(5)      ,/* 企業編號 */
rtecsite       varchar2(10)      ,/* 營運據點 */
rtecdocno       varchar2(20)      ,/* 單據編號 */
rtecseq       number(10,0)      ,/* 項次 */
rtec001       varchar2(40)      ,/* 商品編號 */
rtec002       varchar2(40)      ,/* 商品條碼 */
rtec003       varchar2(256)      ,/* 商品特徵 */
rtecunit       varchar2(10)      ,/* 應用組織 */
rtecud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtecud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtecud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtecud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtecud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtecud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtecud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtecud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtecud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtecud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtecud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtecud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtecud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtecud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtecud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtecud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtecud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtecud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtecud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtecud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtecud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtecud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtecud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtecud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtecud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtecud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtecud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtecud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtecud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtecud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtec_t add constraint rtec_pk primary key (rtecent,rtecdocno,rtecseq) enable validate;

create unique index rtec_pk on rtec_t (rtecent,rtecdocno,rtecseq);

grant select on rtec_t to tiptop;
grant update on rtec_t to tiptop;
grant delete on rtec_t to tiptop;
grant insert on rtec_t to tiptop;

exit;
