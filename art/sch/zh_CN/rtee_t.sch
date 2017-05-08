/* 
================================================================================
檔案代號:rtee_t
檔案名稱:市場調查明細資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtee_t
(
rteeent       number(5)      ,/* 企業編號 */
rteedocno       varchar2(20)      ,/* 單據編號 */
rteeseq       number(10,0)      ,/* 項次 */
rteesite       varchar2(10)      ,/* 營運據點 */
rtee001       varchar2(40)      ,/* 商品編號 */
rtee002       varchar2(40)      ,/* 商品條碼 */
rtee003       varchar2(256)      ,/* 商品特徵 */
rtee004       number(20,6)      ,/* 進價 */
rtee005       number(20,6)      ,/* 售價 */
rtee006       number(20,6)      ,/* 毛利率 */
rtee007       number(20,6)      ,/* 競爭門店售價 */
rtee008       varchar2(1)      ,/* 促銷否 */
rtee009       date      ,/* 促銷結束日期 */
rtee010       varchar2(1)      ,/* 價高標記 */
rtee011       varchar2(1)      ,/* 門店是否跟價 */
rtee012       number(20,6)      ,/* 門店跟價至 */
rtee013       date      ,/* 門店跟價截止日期 */
rtee014       varchar2(10)      ,/* 不跟價原因 */
rteeunit       varchar2(10)      ,/* 應用組織 */
rteeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rteeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rteeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rteeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rteeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rteeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rteeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rteeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rteeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rteeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rteeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rteeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rteeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rteeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rteeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rteeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rteeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rteeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rteeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rteeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rteeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rteeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rteeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rteeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rteeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rteeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rteeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rteeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rteeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rteeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtee_t add constraint rtee_pk primary key (rteeent,rteedocno,rteeseq) enable validate;

create unique index rtee_pk on rtee_t (rteeent,rteedocno,rteeseq);

grant select on rtee_t to tiptop;
grant update on rtee_t to tiptop;
grant delete on rtee_t to tiptop;
grant insert on rtee_t to tiptop;

exit;
