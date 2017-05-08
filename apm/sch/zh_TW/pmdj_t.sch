/* 
================================================================================
檔案代號:pmdj_t
檔案名稱:核價單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdj_t
(
pmdjent       number(5)      ,/* 企業編號 */
pmdjsite       varchar2(10)      ,/* 營運據點 */
pmdjdocno       varchar2(20)      ,/* 核價單號 */
pmdjseq       number(10,0)      ,/* 項次 */
pmdj001       varchar2(1)      ,/* 委外否 */
pmdj002       varchar2(40)      ,/* 料件編號 */
pmdj003       varchar2(256)      ,/* 產品特徵 */
pmdj004       varchar2(40)      ,/* 包裝容器 */
pmdj005       varchar2(40)      ,/* 供應商料號 */
pmdj006       varchar2(10)      ,/* 作業編號 */
pmdj007       varchar2(10)      ,/* 作業序 */
pmdj008       varchar2(10)      ,/* 核價單位 */
pmdj009       varchar2(1)      ,/* 分量計價否 */
pmdj010       number(20,6)      ,/* 上次單價 */
pmdj011       number(20,6)      ,/* 單價 */
pmdj012       number(5,2)      ,/* 稅率 */
pmdj013       number(20,6)      ,/* 折扣率 */
pmdj014       varchar2(10)      ,/* 運輸方式 */
pmdj015       varchar2(10)      ,/* 理由碼 */
pmdj030       varchar2(255)      ,/* 備註 */
pmdj016       varchar2(10)      ,/* 稅別 */
pmdjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdjud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmdj031       varchar2(10)      ,/* 系列 */
pmdj032       varchar2(10)      /* 產品分類 */
);
alter table pmdj_t add constraint pmdj_pk primary key (pmdjent,pmdjdocno,pmdjseq) enable validate;

create unique index pmdj_pk on pmdj_t (pmdjent,pmdjdocno,pmdjseq);

grant select on pmdj_t to tiptop;
grant update on pmdj_t to tiptop;
grant delete on pmdj_t to tiptop;
grant insert on pmdj_t to tiptop;

exit;
