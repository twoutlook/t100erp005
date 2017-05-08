/* 
================================================================================
檔案代號:pmdy_t
檔案名稱:採購合約單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmdy_t
(
pmdyent       number(5)      ,/* 企業編號 */
pmdysite       varchar2(10)      ,/* 營運據點 */
pmdydocno       varchar2(20)      ,/* 合約單號 */
pmdyseq       number(10,0)      ,/* 項次 */
pmdy001       varchar2(1)      ,/* 委外否 */
pmdy002       varchar2(40)      ,/* 料件編號 */
pmdy003       varchar2(256)      ,/* 產品特徵 */
pmdy004       varchar2(40)      ,/* 包裝容器 */
pmdy005       varchar2(40)      ,/* 供應商料號 */
pmdy006       varchar2(10)      ,/* 作業編號 */
pmdy007       varchar2(10)      ,/* 作業序 */
pmdy008       varchar2(10)      ,/* 單位 */
pmdy009       number(20,6)      ,/* 數量 */
pmdy010       number(20,6)      ,/* 單價 */
pmdy011       varchar2(10)      ,/* 稅別 */
pmdy012       number(5,2)      ,/* 稅率 */
pmdy013       varchar2(10)      ,/* 運輸方式 */
pmdy014       varchar2(10)      ,/* 理由碼 */
pmdy017       number(20,6)      ,/* 未稅金額 */
pmdy018       number(20,6)      ,/* 含稅金額 */
pmdy019       number(20,6)      ,/* 稅額 */
pmdy020       number(20,6)      ,/* 累計數量 */
pmdy021       number(20,6)      ,/* 累計未稅金額 */
pmdy022       number(20,6)      ,/* 累計含稅金額 */
pmdy023       number(20,6)      ,/* 累計稅額 */
pmdy024       varchar2(1)      ,/* 累計量定價否 */
pmdy030       varchar2(255)      ,/* 備註 */
pmdyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmdy_t add constraint pmdy_pk primary key (pmdyent,pmdydocno,pmdyseq) enable validate;

create unique index pmdy_pk on pmdy_t (pmdyent,pmdydocno,pmdyseq);

grant select on pmdy_t to tiptop;
grant update on pmdy_t to tiptop;
grant delete on pmdy_t to tiptop;
grant insert on pmdy_t to tiptop;

exit;
