/* 
================================================================================
檔案代號:imcd_t
檔案名稱:料件據點銷售分群檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imcd_t
(
imcdent       number(5)      ,/* 企業編號 */
imcdsite       varchar2(10)      ,/* 營運據點 */
imcd111       varchar2(10)      ,/* 銷售分群 */
imcd112       varchar2(10)      ,/* 銷售單位 */
imcd113       varchar2(10)      ,/* 銷售計價單位 */
imcd114       number(20,6)      ,/* 銷售批量 */
imcd115       number(20,6)      ,/* 最小銷售數量 */
imcd116       varchar2(10)      ,/* 銷售批量控管方式 */
imcd117       number(15,3)      ,/* 保證(固)月數 */
imcd118       number(15,3)      ,/* 保證(固)天數 */
imcd121       varchar2(10)      ,/* 預設內外銷 */
imcd122       varchar2(10)      ,/* 接單拆解方式 */
imcd123       varchar2(40)      ,/* 慣用包裝容器 */
imcd124       number(15,3)      ,/* 銷售備貨提前天數 */
imcd125       varchar2(40)      ,/* 預測料號 */
imcd126       varchar2(1)      ,/* 出貨替代 */
imcd127       varchar2(1)      ,/* 統計除外商品 */
imcdownid       varchar2(20)      ,/* 資料所有者 */
imcdowndp       varchar2(10)      ,/* 資料所屬部門 */
imcdcrtid       varchar2(20)      ,/* 資料建立者 */
imcdcrtdp       varchar2(10)      ,/* 資料建立部門 */
imcdcrtdt       timestamp(0)      ,/* 資料創建日 */
imcdmodid       varchar2(20)      ,/* 資料修改者 */
imcdmoddt       timestamp(0)      ,/* 最近修改日 */
imcdstus       varchar2(10)      ,/* 狀態碼 */
imcd128       number(20,6)      ,/* 銷售超交率 */
imcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imcdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imcd_t add constraint imcd_pk primary key (imcdent,imcdsite,imcd111) enable validate;

create unique index imcd_pk on imcd_t (imcdent,imcdsite,imcd111);

grant select on imcd_t to tiptop;
grant update on imcd_t to tiptop;
grant delete on imcd_t to tiptop;
grant insert on imcd_t to tiptop;

exit;
