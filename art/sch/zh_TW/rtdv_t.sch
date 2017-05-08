/* 
================================================================================
檔案代號:rtdv_t
檔案名稱:自營新商品引進-商品明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtdv_t
(
rtdvent       number(5)      ,/* 企業編號 */
rtdvdocno       varchar2(20)      ,/* 單據編號 */
rtdvseq       number(10,0)      ,/* 項次 */
rtdv001       varchar2(40)      ,/* 商品編號 */
rtdv002       varchar2(40)      ,/* 商品條碼 */
rtdv003       varchar2(1)      ,/* 主供應商否 */
rtdv004       varchar2(10)      ,/* 進項稅目 */
rtdv005       number(5,2)      ,/* No use */
rtdv006       varchar2(10)      ,/* 銷項稅目 */
rtdv007       number(5,2)      ,/* No use */
rtdv008       varchar2(80)      ,/* 產地 */
rtdv009       varchar2(10)      ,/* 採購單位 */
rtdv010       varchar2(10)      ,/* 包裝單位 */
rtdv011       number(15,3)      ,/* 件裝數 */
rtdv012       varchar2(10)      ,/* 配送方式 */
rtdv013       varchar2(20)      ,/* 採購員 */
rtdv014       number(20,6)      ,/* 最小採購量 */
rtdv015       number(20,6)      ,/* 採購倍量 */
rtdv016       number(20,6)      ,/* 最小採購額 */
rtdv017       number(20,6)      ,/* 訂貨數 */
rtdv018       number(20,6)      ,/* 進價 */
rtdv019       number(20,6)      ,/* 含稅進價金額 */
rtdv020       number(20,6)      ,/* 進銷差率 */
rtdv021       varchar2(1)      ,/* 是否保證毛利率 */
rtdv022       number(20,6)      ,/* 保證毛利率 */
rtdv023       number(20,6)      ,/* 售價 */
rtdv024       number(20,6)      ,/* 會員價1 */
rtdv025       number(20,6)      ,/* 會員價2 */
rtdv026       number(20,6)      ,/* 會員價3 */
rtdv027       date      ,/* 生效日期 */
rtdv028       date      ,/* 失效日期 */
rtdv029       varchar2(10)      ,/* 銷售單位 */
rtdvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdvud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtdv030       varchar2(1)      ,/* No use */
rtdv031       number(20,6)      ,/* 未稅進價金額 */
rtdv032       varchar2(10)      ,/* 採購計價單位 */
rtdv033       varchar2(10)      ,/* 採購幣別 */
rtdv034       varchar2(10)      ,/* 採購批量控管方式 */
rtdv035       varchar2(10)      ,/* 供應商選擇方式 */
rtdv036       varchar2(10)      ,/* 採購接單拆解方式 */
rtdv037       number(20,6)      ,/* 採購時損耗率 */
rtdv038       number(20,6)      ,/* 採購超交率 */
rtdv039       number(20,6)      ,/* 結算扣率 */
rtdv040       varchar2(1)      ,/* 手工折價否 */
rtdv101       number(22,2)      ,/* 單位兌換積分 */
rtdv102       number(22,2)      ,/* 促銷單位兌換積分 */
rtdv103       number(22,2)      /* 促銷原單位兌換積分 */
);
alter table rtdv_t add constraint rtdv_pk primary key (rtdvent,rtdvdocno,rtdvseq) enable validate;

create unique index rtdv_pk on rtdv_t (rtdvent,rtdvdocno,rtdvseq);

grant select on rtdv_t to tiptop;
grant update on rtdv_t to tiptop;
grant delete on rtdv_t to tiptop;
grant insert on rtdv_t to tiptop;

exit;
