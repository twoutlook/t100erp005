/* 
================================================================================
檔案代號:imbf_t
檔案名稱:料件申請單料號據點進銷存檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table imbf_t
(
imbfent       number(5)      ,/* 企業編號 */
imbfsite       varchar2(10)      ,/* 營運據點 */
imbfdocno       varchar2(20)      ,/* 申請單號 */
imbf001       varchar2(40)      ,/* 料件編號 */
imbf011       varchar2(10)      ,/* 主分群 */
imbf012       varchar2(10)      ,/* 存貨管制方法 */
imbf013       varchar2(10)      ,/* 補給策略 */
imbf014       varchar2(10)      ,/* 需求計算方法 */
imbf015       varchar2(10)      ,/* 參考單位 */
imbf016       varchar2(10)      ,/* 據點生命週期 */
imbf017       varchar2(10)      ,/* 稅別 */
imbf018       varchar2(1)      ,/* 使用附屬零件 */
imbf021       number(15,3)      ,/* 期間採購月數 */
imbf022       number(15,3)      ,/* 期間採購日數 */
imbf023       number(20,6)      ,/* 期間補足量 */
imbf024       number(20,6)      ,/* 再訂貨點 */
imbf025       number(20,6)      ,/* 再訂貨點量 */
imbf026       number(20,6)      ,/* 安全庫存量 */
imbf027       number(20,6)      ,/* 警戒庫存量 */
imbf031       number(15,3)      ,/* 有效期月數 */
imbf032       number(15,3)      ,/* 有效期加天數 */
imbf033       number(15,3)      ,/* 檢疫/隔離天數 */
imbf034       varchar2(1)      ,/* 保稅料件 */
imbf035       varchar2(40)      ,/* 對應非保稅料號 */
imbf051       varchar2(10)      ,/* 庫存分群 */
imbf052       varchar2(20)      ,/* 倉管員 */
imbf053       varchar2(10)      ,/* 據點庫存單位 */
imbf054       varchar2(1)      ,/* 庫存多單位 */
imbf055       varchar2(10)      ,/* 庫存管理特微 */
imbf056       varchar2(1)      ,/* 庫存管理特徵可空白 */
imbf057       varchar2(10)      ,/* ABC碼 */
imbf058       varchar2(10)      ,/* 存貨備置策略 */
imbf059       varchar2(10)      ,/* 撿貨策略 */
imbf061       varchar2(10)      ,/* 庫存批號控管方式 */
imbf062       varchar2(1)      ,/* 庫存批號自動編碼否 */
imbf063       varchar2(10)      ,/* 庫存批號編碼方式 */
imbf064       varchar2(10)      ,/* 庫存批號唯一性檢查控管 */
imbf071       varchar2(10)      ,/* 製造批號控管方式 */
imbf072       varchar2(1)      ,/* 製造批號自動編碼否 */
imbf073       varchar2(10)      ,/* 製造批號編碼方式 */
imbf074       varchar2(10)      ,/* 製造批號唯一性檢查控管 */
imbf081       varchar2(10)      ,/* 序號控管方式 */
imbf082       varchar2(1)      ,/* 序號自動編碼否 */
imbf083       varchar2(10)      ,/* 序號編碼方式 */
imbf084       varchar2(10)      ,/* 序號唯一性檢查控管 */
imbf091       varchar2(10)      ,/* 預設庫位 */
imbf092       varchar2(10)      ,/* 預設儲位 */
imbf093       varchar2(1)      ,/* no use */
imbf094       number(20,6)      ,/* 盤點容差數 */
imbf095       number(20,6)      ,/* 盤點容差率 */
imbf096       date      ,/* 呆滯日期開帳 */
imbf097       varchar2(10)      ,/* no use */
imbf101       number(20,6)      ,/* 調撥批量 */
imbf102       number(20,6)      ,/* 最小調撥數量 */
imbf111       varchar2(10)      ,/* 銷售分群 */
imbf112       varchar2(10)      ,/* 銷售單位 */
imbf113       varchar2(10)      ,/* 銷售計價單位 */
imbf114       number(20,6)      ,/* 銷售批量 */
imbf115       number(20,6)      ,/* 最小銷售數量 */
imbf116       varchar2(10)      ,/* 銷售批量控管方式 */
imbf117       number(15,3)      ,/* 保證(固)月數 */
imbf118       number(15,3)      ,/* 保證(固)天數 */
imbf121       varchar2(10)      ,/* 預設內外銷 */
imbf122       varchar2(10)      ,/* 接單拆解方式 */
imbf123       varchar2(40)      ,/* 慣用包裝容器 */
imbf124       number(15,3)      ,/* 銷售備貨提前天數 */
imbf125       varchar2(40)      ,/* 預測料號 */
imbf126       varchar2(1)      ,/* 出貨替代 */
imbf127       varchar2(1)      ,/* 統計除外商品 */
imbf128       number(20,6)      ,/* 銷售超交率 */
imbf141       varchar2(10)      ,/* 採購分群 */
imbf142       varchar2(20)      ,/* 採購員 */
imbf143       varchar2(10)      ,/* 採購單位 */
imbf144       varchar2(10)      ,/* 採購計價單位 */
imbf145       number(20,6)      ,/* 採購單位批量 */
imbf146       number(20,6)      ,/* 最小採購數量 */
imbf147       varchar2(10)      ,/* 採購批量控管方式 */
imbf148       number(20,6)      ,/* 經濟訂購量 */
imbf149       number(20,6)      ,/* 平均訂購量 */
imbf151       varchar2(10)      ,/* 預設內外購 */
imbf152       varchar2(10)      ,/* 供應商選擇方式 */
imbf153       varchar2(10)      ,/* 主要供應商 */
imbf154       number(20,6)      ,/* 主供應商分配限量 */
imbf155       number(15,3)      ,/* 分配進位倍數 */
imbf156       varchar2(10)      ,/* 供貨模式 */
imbf157       varchar2(40)      ,/* 慣用包裝容器 */
imbf158       varchar2(10)      ,/* 接單拆解方式(採購) */
imbf161       varchar2(1)      ,/* 採購替代 */
imbf162       varchar2(1)      ,/* 採購收貨替代 */
imbf163       varchar2(1)      ,/* 採購合約沖銷 */
imbf164       number(20,6)      ,/* 採購時損耗率 */
imbf165       number(20,6)      ,/* 採購時備品率 */
imbf166       number(20,6)      ,/* 採購超交率 */
imbf171       number(15,3)      ,/* 採購文件前置時間 */
imbf172       number(15,3)      ,/* 採購交貨前置時間 */
imbf173       number(15,3)      ,/* 採購到廠前置時間 */
imbf174       number(15,3)      ,/* 採購入庫前置時間 */
imbf175       number(15,3)      ,/* 嚴守交期前置時間 */
imbf176       varchar2(10)      ,/* 收貨時段 */
imbfownid       varchar2(20)      ,/* 資料所有者 */
imbfowndp       varchar2(10)      ,/* 資料所屬部門 */
imbfcrtid       varchar2(20)      ,/* 資料建立者 */
imbfcrtdt       timestamp(0)      ,/* 資料創建日 */
imbfcrtdp       varchar2(10)      ,/* 資料建立部門 */
imbfmodid       varchar2(20)      ,/* 資料修改者 */
imbfmoddt       timestamp(0)      ,/* 最近修改日 */
imbfcnfid       varchar2(20)      ,/* 資料確認者 */
imbfcnfdt       timestamp(0)      ,/* 資料確認日 */
imbfpstid       varchar2(20)      ,/* 資料過帳者 */
imbfpstdt       timestamp(0)      ,/* 資料過帳日 */
imbfstus       varchar2(1)      ,/* 資料有效碼 */
imbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imbfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imbf177       varchar2(1)      ,/* 箱盒號條碼管理 */
imbf178       varchar2(10)      ,/* 條碼編碼方式 */
imbf179       number(20,6)      ,/* 條碼包裝數量 */
imbf130       number(20,6)      /* 銷售時備品率 */
);
alter table imbf_t add constraint imbf_pk primary key (imbfent,imbfsite,imbfdocno) enable validate;

create  index imbf_01 on imbf_t (imbf001);
create  index imbf_02 on imbf_t (imbf011);
create  index imbf_03 on imbf_t (imbf051);
create  index imbf_04 on imbf_t (imbf111);
create  index imbf_05 on imbf_t (imbf141);
create unique index imbf_pk on imbf_t (imbfent,imbfsite,imbfdocno);

grant select on imbf_t to tiptop;
grant update on imbf_t to tiptop;
grant delete on imbf_t to tiptop;
grant insert on imbf_t to tiptop;

exit;
