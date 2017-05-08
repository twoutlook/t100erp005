/* 
================================================================================
檔案代號:stby_t
檔案名稱:扣率代銷每日銷售成本明細統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stby_t
(
stbyent       number(5)      ,/* 企業編號 */
stbysite       varchar2(10)      ,/* 營運組織 */
stbydocno       varchar2(20)      ,/* 來源單號 */
stbyseq       number(10,0)      ,/* 來源項次 */
stby001       date      ,/* 銷售日期 */
stby002       varchar2(40)      ,/* 商品編號 */
stby003       varchar2(10)      ,/* 庫區編號 */
stby004       varchar2(10)      ,/* 專櫃編號 */
stby005       varchar2(10)      ,/* 供應商編號 */
stby006       varchar2(10)      ,/* 費用代碼 */
stby007       number(20,6)      ,/* 銷售數量 */
stby008       number(20,6)      ,/* 應收金額 */
stby009       number(20,6)      ,/* 實收金額 */
stby010       number(20,6)      ,/* 扣率 */
stby011       number(20,6)      ,/* 費用金額 */
stby012       number(20,6)      ,/* 成本金額 */
stby013       varchar2(10)      ,/* 日結成本類別 */
stby014       varchar2(10)      ,/* 價款類型 */
stby015       varchar2(1)      ,/* 已結轉否 */
stby016       varchar2(20)      ,/* 成本審批單號 */
stby017       number(10,0)      ,/* 成本審批單項次 */
stby018       varchar2(10)      ,/* 管理品類 */
stby019       number(20,6)      ,/* 促銷銷售額 */
stbyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stbyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stbyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stbyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stbyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stbyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stbyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stbyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stbyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stbyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stbyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stbyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stbyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stbyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stbyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stbyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stbyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stbyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stbyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stbyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stbyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stbyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stbyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stbyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stbyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stbyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stbyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stbyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stbyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stbyud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stby020       varchar2(20)      /* 合同編號 */
);
alter table stby_t add constraint stby_pk primary key (stbyent,stbysite,stbydocno,stbyseq) enable validate;

create unique index stby_pk on stby_t (stbyent,stbysite,stbydocno,stbyseq);

grant select on stby_t to tiptop;
grant update on stby_t to tiptop;
grant delete on stby_t to tiptop;
grant insert on stby_t to tiptop;

exit;
