/* 
================================================================================
檔案代號:prbe_t
檔案名稱:市場調查結果明細資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prbe_t
(
prbeent       number(5)      ,/* 企業編號 */
prbeunit       varchar2(10)      ,/* 應用組織 */
prbesite       varchar2(10)      ,/* 營運據點 */
prbedocno       varchar2(20)      ,/* 單據編號 */
prbeseq       number(10,0)      ,/* 項次 */
prbe001       varchar2(40)      ,/* 商品編號 */
prbe002       varchar2(40)      ,/* 商品條碼 */
prbe003       varchar2(256)      ,/* 商品特征 */
prbe004       number(20,6)      ,/* 進價 */
prbe005       number(20,6)      ,/* 售價 */
prbe006       number(20,6)      ,/* 毛利率 */
prbe007       number(20,6)      ,/* 競爭門店售價 */
prbe008       varchar2(1)      ,/* 促銷否 */
prbe009       date      ,/* 促銷結束日期 */
prbe010       varchar2(1)      ,/* 價高標記 */
prbe011       varchar2(1)      ,/* 門店是否跟價 */
prbe012       number(20,6)      ,/* 門店跟價至 */
prbe013       date      ,/* 門店跟價截止日期 */
prbe014       varchar2(10)      ,/* 不跟價原因 */
prbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prbe015       date      /* 門店跟價開始日期 */
);
alter table prbe_t add constraint prbe_pk primary key (prbeent,prbedocno,prbeseq) enable validate;

create unique index prbe_pk on prbe_t (prbeent,prbedocno,prbeseq);

grant select on prbe_t to tiptop;
grant update on prbe_t to tiptop;
grant delete on prbe_t to tiptop;
grant insert on prbe_t to tiptop;

exit;
